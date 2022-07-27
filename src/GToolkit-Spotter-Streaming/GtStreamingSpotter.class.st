Class {
	#name : #GtStreamingSpotter,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'steps'
	],
	#category : #'GToolkit-Spotter-Streaming-Model'
}

{ #category : #'instance creation' }
GtStreamingSpotter class >> on: anObject [
	^ self new initializeWith: anObject
]

{ #category : #'api - accessing' }
GtStreamingSpotter >> amountOfSteps [
	^ steps size
]

{ #category : #'api - announcer' }
GtStreamingSpotter >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #'api - accessing' }
GtStreamingSpotter >> currentStep [
	^ steps last
]

{ #category : #'api - accessing' }
GtStreamingSpotter >> currentStepIndex [
	^ steps size
]

{ #category : #initialization }
GtStreamingSpotter >> initializeWith: anObject [
	steps := OrderedCollection new.
	steps add: (GtStreamingSpotterStep new initializeWithSpotter: self origin: anObject)
]

{ #category : #'api - accessing' }
GtStreamingSpotter >> steps [
	^ steps
]

{ #category : #'api - announcer' }
GtStreamingSpotter >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
GtStreamingSpotter >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtStreamingSpotter >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (self when: anAnnouncementClass do: aBlock)
		subscriber: aSubscriber;
		yourself
]

{ #category : #'api - announcer' }
GtStreamingSpotter >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
