"
An element that represents a spotter step {{gtClass:GtStreamingSpotterStep}} and shows a grouped list of search results.
It reacts to a change of {{gtMethod:GtStreamingSpotterStep>>#searchQuery:}} by subscribing to {{gtClass:GtStreamingSpotterStepSearchQueryChanged}}.
"
Class {
	#name : #GtStreamingSpotterStepElement,
	#superclass : #BrFrame,
	#traits : 'TGtWithSpotterStep',
	#classTraits : 'TGtWithSpotterStep classTrait',
	#instVars : [
		'resultsElement',
		'startedItemsProviders',
		'loadedItemsProviders',
		'loadingItemsProviders',
		'asyncErrorHandler',
		'executionConfiguration'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #'private - instance creation' }
GtStreamingSpotterStepElement >> createGroup: eachSearchAndResults [
	| aGroup aSearchStream aStreamItemsProvider aSearch aPreloadIndex |

	aSearch := eachSearchAndResults key.
	aSearchStream := eachSearchAndResults value.

	aStreamItemsProvider := BrStreamItemsProvider new
			preloadAmount: 1;
			executionConfiguration: executionConfiguration;
			stream: aSearchStream
				sinks: { AsyncForwardSink new. AsyncCounterSink new }.

	aStreamItemsProvider
		when: BrItemsProviderNewItemsLoadedEvent
		send: #onItemsLoaded:
		to: self.

	aStreamItemsProvider
		when: BrItemsProviderStartedLoadingEvent
		send: #onLoadingStarted:
		to: self.

	aStreamItemsProvider
		when: BrItemsProviderDoneEvent
		send: #onLoadingFinished:
		to: self.

	aGroup := self newGroup: aSearch itemsProvider: aStreamItemsProvider.

	aStreamItemsProvider userData at: #group put: aGroup.

	aSearch isBroken ifFalse: [
		aPreloadIndex := 0.
		aStreamItemsProvider
			preloadUntilFoundSuchThat: [ :each | 
				aPreloadIndex := aPreloadIndex + 1.
				aPreloadIndex = aSearch itemsLimit ] ].

	^ aGroup
]

{ #category : #initialization }
GtStreamingSpotterStepElement >> initialize [
	super initialize.

	self matchParent.

	startedItemsProviders := AsyncMutex for: IdentitySet new.
	loadedItemsProviders := AsyncMutex for: IdentitySet new.
	loadingItemsProviders := AsyncMutex for: IdentitySet new.
	asyncErrorHandler := AsyncPassExceptionHandler new.
	executionConfiguration := AsyncFutureExecutionConfiguration new
		errorHandler: asyncErrorHandler;
		customGroup: #Spotter.

	resultsElement := BrGroupedList new.
	resultsElement
		matchParent;
		when: BrSelectionChanged do: [ self onSelectedCandidateMaybeChanged ];
		when: BrItemsProviderItemsChangedEvent do: [ self onSelectedCandidateMaybeChanged ];
		headerElementStencil: [ self newCategoryElement id: GtSpotterCategoryElementId; spotterStep: spotterStep ];
		headerDataBinder: [ :aCategoryElement :eachGroup | aCategoryElement group: eachGroup ].

	self addChild: resultsElement
]

{ #category : #'private - instance creation' }
GtStreamingSpotterStepElement >> newCategoryElement [
	^ GtStreamingSpotterCategoryElement new
]

{ #category : #'private - instance creation' }
GtStreamingSpotterStepElement >> newGroup: aSearch itemsProvider: aStreamItemsProvider [
	^ aSearch isBroken
		ifTrue: [
			BrGroup new
				itemsProvider: aStreamItemsProvider;
				domainObject: aSearch;
				itemStencil: [ GtStreamingSpotterBrokenSearchElement new spotterStep: self spotterStep ];
				itemDataBinder: [ :aCandidateElement :eachCandidate | aCandidateElement error: eachCandidate item error search: eachCandidate item ] ]
		ifFalse: [
			BrGroup new
				itemsProvider: aStreamItemsProvider;
				domainObject: aSearch;
				itemType: [ :aFactory :eachCandidate |
					eachCandidate isBroken
						ifTrue: [ GtStreamingSpotterBrokenSearchElement ]
						ifFalse: [ GtStreamingSpotterCandidateErrorHandlingElement ] ];
				itemStencil: [ :anElementClass | anElementClass new spotterStep: self spotterStep ];
				itemDataBinder: [ :aCandidateElement :eachCandidate | aCandidateElement candidate: eachCandidate search: aSearch ];
				itemsLimit: aSearch itemsLimit ]
]

{ #category : #'private - event handling' }
GtStreamingSpotterStepElement >> onItemsLoaded: anItemsProviderNewItemsLoadedEvent [
	| anItemsProvider aGroup |

	anItemsProvider := anItemsProviderNewItemsLoadedEvent itemsProvider.
	aGroup := anItemsProvider userData at: #group.

	"the items provider didn't yet load enough items"
	(anItemsProvider isDone or: [ anItemsProvider itemCount >= aGroup itemsLimit ])
		ifFalse: [ ^ self ].
	
	"Remove an items provider from a set of started items providers, exit if it does not exist there"
	startedItemsProviders lock: [ :aSet |
		(aSet remove: anItemsProvider ifAbsent: [ ^ self ]) ].

	loadedItemsProviders lock: [ :aSet |
		(aSet includes: anItemsProvider)
			ifFalse: [ aSet add: anItemsProvider ] ].

	self tryToPreloadTheRest
]

{ #category : #'private - event handling' }
GtStreamingSpotterStepElement >> onLoadingFinished: anItemsProviderDoneEvent [
	| anItemsProvider aGroup |

	anItemsProvider := anItemsProviderDoneEvent itemsProvider.
	aGroup := anItemsProvider userData at: #group.

	startedItemsProviders lock: [ :aSet | aSet remove: anItemsProvider ifAbsent: [ ] ].
	loadingItemsProviders lock: [ :aSet | aSet remove: anItemsProvider ifAbsent: [  ] ].

	self tryToPreloadTheRest
]

{ #category : #'private - event handling' }
GtStreamingSpotterStepElement >> onLoadingStarted: anItemsProviderStartedLoadingEvent [
	| anItemsProvider aGroup |

	anItemsProvider := anItemsProviderStartedLoadingEvent itemsProvider.
	aGroup := anItemsProvider userData at: #group.

	anItemsProviderStartedLoadingEvent initialAmountOfItems < aGroup itemsLimit
		ifTrue: [ startedItemsProviders lock: [ :aCollection |
			(aCollection includes: anItemsProvider)
				ifFalse: [ aCollection add: anItemsProvider ] ] ]
]

{ #category : #'private - event handling' }
GtStreamingSpotterStepElement >> onSearchQueryChanged [
	| aGroupesStream aGroupesItemProvider |
	startedItemsProviders lock: [ :aSet | aSet removeAll ].
	loadedItemsProviders lock: [ :aSet | aSet removeAll ].
	loadingItemsProviders lock: [ :aSet | aSet removeAll ].

	aGroupesStream := spotterStep createSearchResultsStream collect: (WeakMessageSend receiver: self selector: #createGroup:).

	aGroupesItemProvider := BrStreamItemsProvider new
			executionConfiguration: executionConfiguration;
			stream: aGroupesStream.

	resultsElement groupsProvider: aGroupesItemProvider.
	resultsElement selectOne: 2
]

{ #category : #'private - event handling' }
GtStreamingSpotterStepElement >> onSelectedCandidateMaybeChanged [
	self fireEvent: GtStreamingSpotterSelectedCandidateMaybeChanged new
]

{ #category : #'api - spotter step' }
GtStreamingSpotterStepElement >> onSpotterStepChanged [
	"Is sent when a new spotterStep is assigned to the receiver.
	Note: #onSpotterStepChanged is sent before #subscribeToSpotterStep
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSpotterStepChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self onSearchQueryChanged
]

{ #category : #'api - selection' }
GtStreamingSpotterStepElement >> selectNextItem [
	resultsElement selectNext
]

{ #category : #'api - selection' }
GtStreamingSpotterStepElement >> selectPreviousItem [
	resultsElement selectPrevious
]

{ #category : #'api - selection' }
GtStreamingSpotterStepElement >> selectedCandidateDo: aBlock [
	resultsElement selectedEntityDo: [ :anEntity |
		anEntity isItem
			ifFalse: [ ^ self ].
		
		aBlock value: anEntity object ]
]

{ #category : #'api - spotter step' }
GtStreamingSpotterStepElement >> subscribeToSpotterStep [
	"Is sent after a new spotterStep is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSpotterStep if the receiver subscribes to them"
	<modelSubscriber: #spotterStep>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>

	spotterStep
		when: GtStreamingSpotterStepSearchQueryChanged
		send: #onSearchQueryChanged
		to: self
]

{ #category : #'private - event handling' }
GtStreamingSpotterStepElement >> tryToPreloadTheRest [
	"if all item providers loaded their initial batch, we can start taking item providers and finish their searches one by one"
	loadingItemsProviders lock: [ :theAlreadyLoadingProviders |		
		theAlreadyLoadingProviders ifEmpty: [
			startedItemsProviders lock: [ :theStartedItemsProviders | theStartedItemsProviders ifEmpty: [
				loadedItemsProviders lock: [ :theLoadedItemsProviders |
				theLoadedItemsProviders isNotEmpty
					ifTrue: [
						| anItemsProviderToFinish aGroup |
						
						anItemsProviderToFinish := theLoadedItemsProviders anyOne.
						theLoadedItemsProviders remove: anItemsProviderToFinish.
						theAlreadyLoadingProviders add: anItemsProviderToFinish.
						
						aGroup := anItemsProviderToFinish userData at: #group.

						(anItemsProviderToFinish preloadUntilFoundSuchThat: [ :each | false ])
							then: [ loadingItemsProviders lock: [ :aSet | aSet remove: anItemsProviderToFinish ifAbsent: [  ] ] ]
							otherwise: [ loadingItemsProviders lock: [ :aSet | aSet remove: anItemsProviderToFinish ifAbsent: [  ] ] ] ] ] ] ] ] ].
]

{ #category : #'api - spotter step' }
GtStreamingSpotterStepElement >> unsubscribeFromSpotterStep [
	"Is sent before a new spotterStep is assigned to the receiver.
	Objects that subscribe to spotterStep are required to implement this method."
	<modelUnsubscriber: #spotterStep>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	spotterStep unsubscribe: self
]

{ #category : #'private - event handling' }
GtStreamingSpotterStepElement >> updateLabel: aLabelElement forGroup: eachGroup [
	| groupTitle currentAmountOfItems isDone |

	currentAmountOfItems := eachGroup itemsProvider sinks second count.
	isDone := eachGroup itemsProvider isDone.
	
	groupTitle := String
			streamContents: [ :aStream | 
				aStream
					nextPutAll: eachGroup domainObject title;
					space;
					nextPut: $(;
					print: (currentAmountOfItems min: eachGroup itemsLimit);
					space;
					nextPut: $/;
					space;
					nextPutAll: (isDone ifTrue: [ currentAmountOfItems asString ] ifFalse: [ '...' ]);
					nextPut: $) ].

	aLabelElement text: groupTitle
]
