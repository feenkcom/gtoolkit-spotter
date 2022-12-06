Class {
	#name : #GtStreamingSpotter,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'steps',
		'currentStep',
		'isDebugMode',
		'shouldShowPreview'
	],
	#category : #'GToolkit-Spotter-Streaming-Model'
}

{ #category : #accessing }
GtStreamingSpotter class >> enable: aBoolean [
	self deprecated: 'Spotter is enabled by default'
]

{ #category : #accessing }
GtStreamingSpotter class >> extensionsPragma [
	^ #gtSearch
]

{ #category : #accessing }
GtStreamingSpotter class >> isEnabled [
	^ true
]

{ #category : #accessing }
GtStreamingSpotter class >> isEnabledChoiceMade [
	^ true
]

{ #category : #'instance creation' }
GtStreamingSpotter class >> on: anObject [
	^ self new initializeWith: anObject
]

{ #category : #accessing }
GtStreamingSpotter class >> spotterExtendingMethods [

	^ (SystemNavigation default allBehaviors
		flatCollect: [ :each | 
			(Pragma allNamed: self extensionsPragma in: each) 
				collect: [ :p | p method asRingDefinition ] ])
		sorted
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

{ #category : #'api - announcer' }
GtStreamingSpotter >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
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

{ #category : #'gt-extension' }
GtStreamingSpotter >> gtStepsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Steps';
		priority: 5;
		items: [ self steps ]
]

{ #category : #'api - accessing' }
GtStreamingSpotter >> hidePreview [
	self showPreview: false
]

{ #category : #initialization }
GtStreamingSpotter >> initialize [
	super initialize.

	steps := OrderedCollection new.
	isDebugMode := false.
	shouldShowPreview := true
]

{ #category : #initialization }
GtStreamingSpotter >> initializeWith: anObject [
	self pushStep: anObject
]

{ #category : #'api - accessing' }
GtStreamingSpotter >> isDebugMode [
	^ isDebugMode
]

{ #category : #'private - notifying' }
GtStreamingSpotter >> notifyActOn: anObject dueTo: anEventType search: aSpotterSearch step: aSpotterStep [
	<return: #GtSpotterObjectActOn>
	| anAnnouncement |
	
	anAnnouncement := GtSpotterObjectActOn new 
		rawObject: anObject;
		eventType: anEventType;
		search: aSpotterSearch;
		step: aSpotterStep.
	
	self announce: anAnnouncement.
	
	^ anAnnouncement
]

{ #category : #'private - notifying' }
GtStreamingSpotter >> notifyCurrentStepChanged: aSpotterStep at: aStepIndex [
	<return: #GtStreamingSpotterCurrentStepChanged>
	| anAnnouncement |
	
	anAnnouncement := GtStreamingSpotterCurrentStepChanged new 
		spotterStep: aSpotterStep;
		stepIndex: aStepIndex.

	self announce: anAnnouncement.
	
	^ anAnnouncement
]

{ #category : #'private - notifying' }
GtStreamingSpotter >> notifyDebugModeChanged [
	<return: #GtStreamingSpotterDebugModeChanged>
	| anAnnouncement |
	
	anAnnouncement := GtStreamingSpotterDebugModeChanged new 
		isDebugMode: isDebugMode.

	self announce: anAnnouncement.
	
	^ anAnnouncement
]

{ #category : #'private - notifying' }
GtStreamingSpotter >> notifyPreviewStateChanged [
	<return: #GtStreamingSpotterPreviewModeChanged>
	| anAnnouncement |
	
	anAnnouncement := GtStreamingSpotterPreviewModeChanged new 
		shouldShowPreview: shouldShowPreview.

	self announce: anAnnouncement.
	
	^ anAnnouncement
]

{ #category : #'private - notifying' }
GtStreamingSpotter >> notifyStepPopped: aSpotterStep at: aStepIndex [
	<return: #GtStreamingSpotterStepPopped>
	| anAnnouncement |
	
	anAnnouncement := GtStreamingSpotterStepPopped new 
		spotterStep: aSpotterStep;
		stepIndex: aStepIndex.

	self announce: anAnnouncement.
	
	^ anAnnouncement
]

{ #category : #'private - notifying' }
GtStreamingSpotter >> notifyStepPushed: aSpotterStep [
	<return: #GtStreamingSpotterStepPushed>
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
			| aNewCurrentStep aPoppedStep aPoppedStepIndex |

			aPoppedStepIndex := theSteps size.
			
			aNewCurrentStep := theSteps at: aPoppedStepIndex - 1.
			self currentStep: aNewCurrentStep.
			
			aPoppedStep := theSteps removeLast.
			aPoppedStep removeFromSpotter.
			
			self
				notifyStepPopped: aPoppedStep
				at: aPoppedStepIndex.
				
			aPoppedStep ]
]

{ #category : #'api - steps' }
GtStreamingSpotter >> popUntil: aSpotterStep [
	"Remove steps until a given step does not become the last one"

	[ steps last == aSpotterStep ]
		whileFalse: [ self popStep ]
]

{ #category : #'api - steps' }
GtStreamingSpotter >> popUntilIncluding: aSpotterStep [
	"Remove steps until a given step does not become the last one"

	[ steps last == aSpotterStep ]
		whileFalse: [ self popStep ].
	steps size > 1 ifTrue: [ self popStep ]
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
GtStreamingSpotter >> shouldShowPreview [
	^ shouldShowPreview
]

{ #category : #'api - accessing' }
GtStreamingSpotter >> showPreview [
	self showPreview: true
]

{ #category : #'api - accessing' }
GtStreamingSpotter >> showPreview: aBoolean [
	shouldShowPreview = aBoolean
		ifTrue: [ ^ self ].

	shouldShowPreview := aBoolean.
	self notifyPreviewStateChanged
]

{ #category : #'api - accessing' }
GtStreamingSpotter >> steps [
	^ steps
]

{ #category : #'api - actions' }
GtStreamingSpotter >> switchToDebugMode [
	isDebugMode := true.
	self notifyDebugModeChanged
]

{ #category : #'api - actions' }
GtStreamingSpotter >> switchToProductionMode [
	isDebugMode := false.
	self notifyDebugModeChanged
]

{ #category : #'api - accessing' }
GtStreamingSpotter >> togglePreview [
	self shouldShowPreview
		ifTrue: [ self hidePreview ]
		ifFalse: [ self showPreview ]
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
