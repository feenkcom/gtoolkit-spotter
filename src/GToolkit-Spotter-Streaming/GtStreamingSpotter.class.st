Class {
	#name : #GtStreamingSpotter,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'steps',
		'currentStep'
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

{ #category : #'api - steps' }
GtStreamingSpotter >> currentStep [
	^ currentStep
]

{ #category : #'api - steps' }
GtStreamingSpotter >> currentStep: aSpotterStep [
	| aStepIndex |
	
	aStepIndex := steps
		indexOf: aSpotterStep
		ifAbsent: [ ^ self ].
	
	currentStep == aSpotterStep
		ifTrue: [ ^ self ].
	
	currentStep := aSpotterStep.
	self
		notifyCurrentStepChanged: aSpotterStep
		at: aStepIndex
]

{ #category : #'api - steps' }
GtStreamingSpotter >> currentStepIndex [
	^ steps
		indexOf: currentStep
		ifAbsent: [ self error: 'Current step is wrong' ]
]

{ #category : #initialization }
GtStreamingSpotter >> initialize [
	super initialize.

	steps := OrderedCollection new
]

{ #category : #initialization }
GtStreamingSpotter >> initializeWith: anObject [
	self pushStep: anObject
]

{ #category : #'private - notifying' }
GtStreamingSpotter >> notifyActOn: anObject for: anEventType [
	<return: #GtSpotterActOn>
	| anAnnouncement |
	
	anAnnouncement := GtSpotterActOn new 
		element: anObject;
		eventType: anEventType.
	
	self announce: anAnnouncement.
	
	^ anAnnouncement
]

{ #category : #'private - notifying' }
GtStreamingSpotter >> notifyCurrentStepChanged: aSpotterStep at: aStepIndex [
	<return: #GtSpotterActOn>
	| anAnnouncement |
	
	anAnnouncement := GtStreamingSpotterCurrentStepChanged new 
		spotterStep: aSpotterStep;
		stepIndex: aStepIndex.

	self announce: anAnnouncement.
	
	^ anAnnouncement
]

{ #category : #'private - notifying' }
GtStreamingSpotter >> notifyStepPopped: aSpotterStep at: aStepIndex [
	<return: #GtSpotterActOn>
	| anAnnouncement |
	
	anAnnouncement := GtStreamingSpotterStepPopped new 
		spotterStep: aSpotterStep;
		stepIndex: aStepIndex.

	self announce: anAnnouncement.
	
	^ anAnnouncement
]

{ #category : #'private - notifying' }
GtStreamingSpotter >> notifyStepPushed: aSpotterStep [
	<return: #GtSpotterActOn>
	| anAnnouncement |
	
	anAnnouncement := GtStreamingSpotterStepPushed new 
		spotterStep: aSpotterStep.

	self announce: anAnnouncement.
	
	^ anAnnouncement
]

{ #category : #'api - steps' }
GtStreamingSpotter >> popStep [
	^ steps
		ifEmpty: [ self error: 'There are no steps to pop' ]
		ifNotEmpty: [ :theSteps |
			| aPoppedStep aPoppedStepIndex |

			aPoppedStepIndex := theSteps size.
			aPoppedStep := theSteps removeLast.
			aPoppedStep removeFromSpotter.
			self
				notifyStepPopped: aPoppedStep
				at: aPoppedStepIndex.
				
			self currentStep: theSteps last.

			aPoppedStep ]
]

{ #category : #'api - steps' }
GtStreamingSpotter >> popUntil: aSpotterStep [
	"Remove steps until a given step does not become the last one"

	[ steps last == aSpotterStep ]
		whileFalse: [ self popStep ]
]

{ #category : #'api - steps' }
GtStreamingSpotter >> pushStep: anOriginObject [
	<return: #GtStreamingSpotterStep>
	| aNewStep shouldAsssignCurrentStep |
	
	aNewStep := GtStreamingSpotterStep new initializeWithSpotter: self origin: anOriginObject.
	steps add: aNewStep.

	shouldAsssignCurrentStep := currentStep isNil.
	shouldAsssignCurrentStep ifTrue: [ currentStep := aNewStep ].

	self notifyStepPushed: aNewStep.

	shouldAsssignCurrentStep ifTrue: [ self notifyCurrentStepChanged: aNewStep at: steps size ].
	
	^ aNewStep
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