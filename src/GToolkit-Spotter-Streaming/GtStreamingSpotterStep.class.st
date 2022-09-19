Class {
	#name : #GtStreamingSpotterStep,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'spotter',
		'origin',
		'searchQuery'
	],
	#category : #'GToolkit-Spotter-Streaming-Model'
}

{ #category : #'api - announcer' }
GtStreamingSpotterStep >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #'api - step' }
GtStreamingSpotterStep >> canDiveIn: anObject [
	<return: #TAsyncFuture>

	^ (GtSpotterUnorderedSearchesStream forOriginObject: anObject) isNotEmpty
]

{ #category : #'api - step' }
GtStreamingSpotterStep >> categoryActOn: aCategory search: aSearch dueTo: anEventType from: anElement [
	"Perform an action associated with the given candidate item.
	(can be triggered by doubleClick: or keyboard Enter press)"
	| anAnnouncement |
	
	self
		assert: [ aCategory isNotNil ]
		description: [ 'Spotter can not perform an action due to ', 
			anEventType asString, 
			' if there is no category' ].
	
	anAnnouncement := spotter
		notifyActOn: aCategory
		for: anEventType.
	
	anAnnouncement isActedUpon
		ifTrue: [ ^ self ].
	
	aSearch
		categoryActOn: aCategory
		for: self
		from: anElement
]

{ #category : #'api - search' }
GtStreamingSpotterStep >> createSearchContext [
	^ GtStreamingSpotterContext new searchQuery: searchQuery
]

{ #category : #'api - search' }
GtStreamingSpotterStep >> createSearchResultsStream [
	^ self createSearchesStream collect: [ :eachSpotterSearch |
		| aContext aResultsStream |
		
		aContext := self createSearchContext.
		aResultsStream := eachSpotterSearch asStreamFor: aContext.
		eachSpotterSearch -> aResultsStream ]
]

{ #category : #'api - search' }
GtStreamingSpotterStep >> createSearchesStream [
	^ GtSpotterOrderedSearchesStream forOriginObject: origin
]

{ #category : #'api - step' }
GtStreamingSpotterStep >> diveIn: anOriginObject dueTo: anEventType [
	| aNewStep |

	aNewStep := self requestNextStepWith: anOriginObject.
	spotter currentStep: aNewStep
]

{ #category : #'api - step' }
GtStreamingSpotterStep >> diveOutDueTo: anEventType [
	spotter popUntilIncluding: self
]

{ #category : #'api - step' }
GtStreamingSpotterStep >> exit [
	self flag: #TODO.
]

{ #category : #initialization }
GtStreamingSpotterStep >> initializeWithSpotter: aStreamingSpotter origin: anObject [
	spotter := aStreamingSpotter.
	origin := anObject.
	searchQuery := ''
]

{ #category : #'api - step' }
GtStreamingSpotterStep >> itemActOn: anItemObject search: aSpotterSearch dueTo: anEventType from: anElement [
	"Perform an action associated with the given candidate item.
	(can be triggered by doubleClick: or keyboard Enter press)"
	| anAnnouncement anObjectToActOn |
	
	self
		assert: [ anItemObject isNotNil ]
		description: [ 'Spotter can not perform an action due to ', 
			anEventType asString, 
			' if there is no candidate' ].
	
	anObjectToActOn := aSpotterSearch objectToActOn: anItemObject from: self.
	
	anAnnouncement := spotter
		notifyActOn: anObjectToActOn
		for: anEventType.
	
	anAnnouncement isActedUpon
		ifTrue: [ ^ self ].
	
	aSpotterSearch
		itemActOn: anObjectToActOn
		for: self
		from: anElement
]

{ #category : #'api - accessing' }
GtStreamingSpotterStep >> origin [
	^ origin
]

{ #category : #initialization }
GtStreamingSpotterStep >> removeFromSpotter [
	spotter := nil.
]

{ #category : #'api - step' }
GtStreamingSpotterStep >> requestNextStepWith: anOriginObject [
	<return: #GtStreamingSpotterStep>

	^ spotter
		popUntil: self;
		pushStep: anOriginObject
]

{ #category : #'api - accessing' }
GtStreamingSpotterStep >> searchQuery [
	^ searchQuery
]

{ #category : #'api - accessing' }
GtStreamingSpotterStep >> searchQuery: aString [
	searchQuery := aString.
	
	self announce: (GtStreamingSpotterStepSearchQueryChanged new)
]

{ #category : #'api - announcer' }
GtStreamingSpotterStep >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
GtStreamingSpotterStep >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtStreamingSpotterStep >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (self when: anAnnouncementClass do: aBlock)
		subscriber: aSubscriber;
		yourself
]

{ #category : #'api - announcer' }
GtStreamingSpotterStep >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
