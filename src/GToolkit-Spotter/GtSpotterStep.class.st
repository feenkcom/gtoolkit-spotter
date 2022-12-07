Class {
	#name : #GtSpotterStep,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'spotter',
		'origin',
		'searchQuery'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #'api - announcer' }
GtSpotterStep >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #'api - step' }
GtSpotterStep >> canDiveIn: anObject [
	<return: #TAsyncFuture>

	^ (GtSpotterUnorderedSearchesStream forOriginObject: anObject context: self createSearchContext) isNotEmpty
]

{ #category : #'api - step' }
GtSpotterStep >> categoryActOn: aCategory search: aSearch dueTo: anEventType from: anElement [
	"Perform an action associated with the given candidate item.
	(can be triggered by doubleClick: or keyboard Enter press)"

	| anAnnouncement |
	self
		assert: [ aCategory isNotNil ]
		description: [ 'Spotter can not perform an action due to ' , anEventType asString
				, ' if there is no category' ].

	anAnnouncement := spotter
			notifyActOn: aCategory
			dueTo: anEventType
			search: nil
			step: nil.

	anAnnouncement isActedUpon ifTrue: [ ^ self ].

	aSearch
		categoryActOn: aCategory
		for: self
		from: anElement
]

{ #category : #'api - search' }
GtSpotterStep >> createSearchContext [
	^ GtSpotterContext new searchQuery: searchQuery
]

{ #category : #'api - search' }
GtSpotterStep >> createSearchResultsStream [
	| aSpotterContext |
	
	aSpotterContext := self createSearchContext.

	^ (self createSearchesStream: aSpotterContext) collect: [ :eachSpotterSearch |
		| aSpotterSearch aResultsStream |
		
		aSpotterSearch := eachSpotterSearch.
		aResultsStream := [ eachSpotterSearch asStreamFor: aSpotterContext ]
			on: Error
			do: [ :anError |
				aSpotterSearch := GtSpotterBrokenSearch new
					priority: aSpotterSearch priority;
					title: aSpotterSearch title;
					error: anError;
					definingMethod: aSpotterSearch definingMethod.
				aSpotterSearch asStreamFor: aSpotterContext ].
		
		aResultsStream := aResultsStream collect: [ :anItem |
			GtSpotterCandidate new item: anItem search: aSpotterSearch ].

		aResultsStream := aResultsStream
			on: Error
			do: [ :anError |
				GtSpotterBrokenCandidate new item: anError copy freeze search: aSpotterSearch ].
		
		aSpotterSearch -> aResultsStream ]
]

{ #category : #'api - search' }
GtSpotterStep >> createSearchesStream [
	^ self createSearchesStream: self createSearchContext
]

{ #category : #'api - search' }
GtSpotterStep >> createSearchesStream: aSpotterContext [
	^ GtSpotterOrderedSearchesStream forSearches: (origin gtSpotterSearchesInContext: aSpotterContext) asAsyncStream
]

{ #category : #'api - step' }
GtSpotterStep >> diveIn: anOriginObject dueTo: anEventType [
	| aNewStep |

	aNewStep := self requestNextStepWith: anOriginObject.
	spotter currentStep: aNewStep
]

{ #category : #'api - step' }
GtSpotterStep >> diveOutDueTo: anEventType [
	spotter popUntilIncluding: self
]

{ #category : #'api - step' }
GtSpotterStep >> exit [
	self flag: #TODO.
]

{ #category : #printing }
GtSpotterStep >> gtDisplayOn: aStream [
	aStream
		nextPutAll: 'Step on ';
		print: origin;
		nextPutAll: ' searching for ';
		print: searchQuery
]

{ #category : #'gt - extensions' }
GtSpotterStep >> gtResultsFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Results';
		priority: 6;
		object: [ self createSearchResultsStream ];
		view: #gtLiveFor:
]

{ #category : #'gt - extensions' }
GtSpotterStep >> gtSearchesFor: aView [
	<gtView>
	
	^ aView forward
		title: 'Searches';
		priority: 5;
		object: [ self createSearchesStream ];
		view: #gtLiveFor:
]

{ #category : #initialization }
GtSpotterStep >> initializeWithSpotter: aStreamingSpotter origin: anObject [
	spotter := aStreamingSpotter.
	origin := anObject.
	searchQuery := ''
]

{ #category : #'api - step' }
GtSpotterStep >> itemActOn: anItemObject search: aSpotterSearch dueTo: anEventType from: anElement [
	"Perform an action associated with the given candidate item.
	(can be triggered by doubleClick: or keyboard Enter press)"

	| anAnnouncement |
	self
		assert: [ anItemObject isNotNil ]
		description: [ 'Spotter can not perform an action due to ' , anEventType asString
				, ' if there is no candidate' ].

	anAnnouncement := spotter
		notifyActOn: anItemObject
		dueTo: anEventType
		search: aSpotterSearch
		step: self.

	anAnnouncement isActedUpon
		ifTrue: [ ^ self ].

	aSpotterSearch
		itemActOn: anItemObject
		for: self
		from: anElement
]

{ #category : #'api - accessing' }
GtSpotterStep >> origin [
	^ origin
]

{ #category : #initialization }
GtSpotterStep >> removeFromSpotter [
	spotter := nil.
]

{ #category : #'api - step' }
GtSpotterStep >> requestNextStepWith: anOriginObject [
	<return: #GtSpotterStep>

	^ spotter
		popUntil: self;
		pushStep: anOriginObject
]

{ #category : #'api - accessing' }
GtSpotterStep >> searchQuery [
	^ searchQuery
]

{ #category : #'api - accessing' }
GtSpotterStep >> searchQuery: aString [
	searchQuery := aString.
	
	self announce: (GtSpotterStepSearchQueryChanged new)
]

{ #category : #'api - announcer' }
GtSpotterStep >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
GtSpotterStep >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtSpotterStep >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (self when: anAnnouncementClass do: aBlock)
		subscriber: aSubscriber;
		yourself
]

{ #category : #'api - announcer' }
GtSpotterStep >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
