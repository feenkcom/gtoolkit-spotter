"
An element that represents a spotter step {{gtClass:GtStreamingSpotterStep}} and shows a grouped list of search results.
It reacts to a change of {{gtMethod:GtStreamingSpotterStep>>#searchQuery:}} by subscribing to {{gtClass:GtStreamingSpotterStepSearchQueryChanged}}.
"
Class {
	#name : #GtStreamingSpotterStepElement,
	#superclass : #BrFrame,
	#traits : 'TGtStreamingWithSpotterStep',
	#classTraits : 'TGtStreamingWithSpotterStep classTrait',
	#instVars : [
		'resultsElement',
		'startedItemsProviders',
		'loadedItemsProviders',
		'loadingItemsProviders'
	],
	#category : #'GToolkit-Spotter-Streaming-UI'
}

{ #category : #initialization }
GtStreamingSpotterStepElement >> initialize [
	super initialize.

	self matchParent.

	startedItemsProviders := AsyncMutex for: IdentitySet new.
	loadedItemsProviders := AsyncMutex for: IdentitySet new.
	loadingItemsProviders := AsyncMutex for: IdentitySet new.

	resultsElement := BrGroupedList new.
	resultsElement
		matchParent;
		when: BrSelectionChanged do: [ :anEvent | self onItemSelectionChanged: anEvent ];
		headerElementStencil: [ BrLabel new
				hMatchParent;
				margin: (BlInsets top: 10);
				aptitude: (BrGlamorousLabelAptitude new foreground: Color gray) ];
		headerDataBinder: [ :aLabel :eachGroup | 
			self updateLabel: aLabel forGroup: eachGroup.
			aLabel
				withAsyncSinkDo: [ :anElementSink |
					anElementSink
						whenUpdate: [ :aLabelElement | self updateLabel: aLabel forGroup: eachGroup. ] ].
			eachGroup itemsProvider sinks first sink: aLabel asyncSink.
			aLabel ].

	self addChild: resultsElement
]

{ #category : #'private - instance creation' }
GtStreamingSpotterStepElement >> newCandidateElement [
	^ GtStreamingSpotterCandidateElement new
]

{ #category : #'private - event handling' }
GtStreamingSpotterStepElement >> onItemSelectionChanged: anEvent [
	| anEntity aSelectedItem |
	
	anEvent selectedInterval ifNil: [ ^ self ].
	
	anEntity := resultsElement viewModel entityAt: anEvent selectedInterval first.

	anEntity isItem
		ifFalse: [ ^ self ].
		
	aSelectedItem := anEntity object.
	self spotterStep select: aSelectedItem dueTo: #singleClick.
]

{ #category : #'private - event handling' }
GtStreamingSpotterStepElement >> onItemsLoaded: anItemsProviderNewItemsLoadedEvent [
	| anItemsProvider aGroup |

	anItemsProvider := anItemsProviderNewItemsLoadedEvent itemsProvider.
	aGroup := anItemsProvider userData at: #group.
	
	NonInteractiveTranscript stdout nextPutAll: 'Loaded ', anItemsProvider itemCount asString; cr.

	"the items provider didn't yet load enough items"
	anItemsProvider itemCount >= aGroup itemsLimit
		ifFalse: [ ^ self ].
	
	"Remove an items provider from a set of started items providers, exit if it does not exist there"
	startedItemsProviders lock: [ :aSet | (aSet remove: anItemsProvider ifAbsent: [ ^ self ]) ].
	loadedItemsProviders lock: [ :aSet |
		(aSet includes: anItemsProvider)
			ifFalse: [
				NonInteractiveTranscript stdout
					nextPutAll: 'Add ';
					nextPutAll: aGroup domainObject title;
					nextPutAll:' to #loadedItemsProviders';
					cr.
				
				aSet add: anItemsProvider ] ].
	
	"if all item providers loaded their initial batch, we can start taking item providers and finish their searches one by one"
	loadingItemsProviders lock: [ :theAlreadyLoadingProviders |
		NonInteractiveTranscript stdout
			nextPutAll: '#loadingItemsProviders: ';
			print: theAlreadyLoadingProviders;
			cr.
		
		theAlreadyLoadingProviders ifEmpty: [
			startedItemsProviders lock: [ :theStartedItemsProviders | theStartedItemsProviders ifEmpty: [
				loadedItemsProviders lock: [ :theLoadedItemsProviders |
				theLoadedItemsProviders isNotEmpty
					ifTrue: [
						| anItemsProviderToFinish |
						
						anItemsProviderToFinish := theLoadedItemsProviders anyOne.
						theLoadedItemsProviders remove: anItemsProviderToFinish.
						theAlreadyLoadingProviders add: anItemsProviderToFinish.
						NonInteractiveTranscript stdout nextPutAll: 'Load the rest of the items: ', aGroup domainObject title asString; cr.
						(anItemsProviderToFinish preloadUntilFoundSuchThat: [ :each | false ])
							then: [ loadingItemsProviders lock: [ :aSet | aSet remove: anItemsProviderToFinish ifAbsent: [  ] ] ]
							otherwise: [ loadingItemsProviders lock: [ :aSet | aSet remove: anItemsProviderToFinish ifAbsent: [  ] ] ] ] ] ] ] ] ].
]

{ #category : #'private - event handling' }
GtStreamingSpotterStepElement >> onLoadingStarted: anItemsProviderStartedLoadingEvent [
	| anItemsProvider aGroup |

	anItemsProvider := anItemsProviderStartedLoadingEvent itemsProvider.
	aGroup := anItemsProvider userData at: #group.

	NonInteractiveTranscript stdout
		nextPutAll: 'Started loading ';
		nextPutAll: aGroup domainObject title;
		nextPutAll:' (';
		print: anItemsProviderStartedLoadingEvent initialAmountOfItems;
		nextPutAll: ')';
		cr.

	anItemsProviderStartedLoadingEvent initialAmountOfItems < aGroup itemsLimit
		ifTrue: [ startedItemsProviders lock: [ :aCollection |
			(aCollection includes: anItemsProvider)
				ifFalse: [
					NonInteractiveTranscript stdout
						nextPutAll: 'Add ';
						nextPutAll: aGroup domainObject title;
						nextPutAll:' to #startedItemsProviders';
						cr.
					aCollection add: anItemsProvider ] ] ]
]

{ #category : #'private - event handling' }
GtStreamingSpotterStepElement >> onSearchQueryChanged [
	| aGroupesStream |
	
	startedItemsProviders lock: [ :aSet | aSet removeAll ].
	loadedItemsProviders lock: [ :aSet | aSet removeAll ].
	loadingItemsProviders lock: [ :aSet | aSet removeAll ].
	
	aGroupesStream := spotterStep createSearchResultsStream collect: [ :eachSearchAndResults |
		| aSearch aSearchStream aStreamItemsProvider aGroup |
		
		aSearch := eachSearchAndResults key.
		aSearchStream := eachSearchAndResults value.
		
		aStreamItemsProvider := BrStreamItemsProvider new
			stream: aSearchStream
			sinks: { AsyncForwardSink new . AsyncCounterSink new };
			preloadAmount: 5.

		aStreamItemsProvider
			when: BrItemsProviderNewItemsLoadedEvent
			send: #onItemsLoaded:
			to: self.
			
		aStreamItemsProvider
			when: BrItemsProviderStartedLoadingEvent
			send: #onLoadingStarted:
			to: self.
		
		aGroup := BrGroup new
			itemsProvider: aStreamItemsProvider;
			domainObject: aSearch;
			itemStencil: [ self newCandidateElement ];
			itemDataBinder: [ :aCandidateElement :eachItem |
				aCandidateElement
					spotterStep: self spotterStep;
					candidate: eachItem search: aSearch ];
			itemsLimit: 5.
			
		aStreamItemsProvider userData at: #group put: aGroup.

		aGroup ].

	resultsElement groupsProvider: aGroupesStream
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