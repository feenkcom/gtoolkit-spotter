Class {
	#name : #GtSpotter,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'steps',
		'currentStep',
		'isDebugMode',
		'shouldShowPreview'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #accessing }
GtSpotter class >> enable: aBoolean [
	self deprecated: 'Spotter is enabled by default'
]

{ #category : #accessing }
GtSpotter class >> extensionsPragma [
	^ #gtSearch
]

{ #category : #accessing }
GtSpotter class >> isEnabled [
	^ true
]

{ #category : #accessing }
GtSpotter class >> isEnabledChoiceMade [
	^ true
]

{ #category : #'instance creation' }
GtSpotter class >> on: anObject [
	^ self new initializeWith: anObject
]

{ #category : #accessing }
GtSpotter class >> spotterExtendingMethods [

	^ (Smalltalk environment allBehaviors
		flatCollect: [ :each | 
			(Pragma allNamed: self extensionsPragma in: each) 
				collect: [ :p | p method asRingDefinition ] ])
		sorted
]

{ #category : #'api - accessing' }
GtSpotter >> amountOfSteps [
	^ steps size
]

{ #category : #'api - announcer' }
GtSpotter >> announce: anAnnouncement [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#announceTemplate'>
	announcer ifNotNil: [ :anAnnouncer | anAnnouncer announce: anAnnouncement ].
]

{ #category : #'api - announcer' }
GtSpotter >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'api - steps' }
GtSpotter >> currentStep [
	^ currentStep
]

{ #category : #'api - steps' }
GtSpotter >> currentStep: aSpotterStep [
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
GtSpotter >> currentStepIndex [
	^ steps
		indexOf: currentStep
		ifAbsent: [ self error: 'Current step is wrong' ]
]

{ #category : #'gt-extension' }
GtSpotter >> gtStepsFor: aView [
	<gtView>
	
	^ aView list
		title: 'Steps';
		priority: 5;
		items: [ self steps ]
]

{ #category : #'api - accessing' }
GtSpotter >> hidePreview [
	self showPreview: false
]

{ #category : #initialization }
GtSpotter >> initialize [
	super initialize.

	steps := OrderedCollection new.
	isDebugMode := false.
	shouldShowPreview := true
]

{ #category : #initialization }
GtSpotter >> initializeWith: anObject [
	self pushStep: anObject
]

{ #category : #'api - accessing' }
GtSpotter >> isDebugMode [
	^ isDebugMode
]

{ #category : #'private - notifying' }
GtSpotter >> notifyActOn: anObject dueTo: anEventType search: aSpotterSearch step: aSpotterStep [
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
GtSpotter >> notifyCurrentStepChanged: aSpotterStep at: aStepIndex [
	<return: #GtSpotterCurrentStepChanged>
	| anAnnouncement |
	
	anAnnouncement := GtSpotterCurrentStepChanged new 
		spotterStep: aSpotterStep;
		stepIndex: aStepIndex.

	self announce: anAnnouncement.
	
	^ anAnnouncement
]

{ #category : #'private - notifying' }
GtSpotter >> notifyDebugModeChanged [
	<return: #GtSpotterDebugModeChanged>
	| anAnnouncement |
	
	anAnnouncement := GtSpotterDebugModeChanged new 
		isDebugMode: isDebugMode.

	self announce: anAnnouncement.
	
	^ anAnnouncement
]

{ #category : #'private - notifying' }
GtSpotter >> notifyPreviewStateChanged [
	<return: #GtSpotterPreviewModeChanged>
	| anAnnouncement |
	
	anAnnouncement := GtSpotterPreviewModeChanged new 
		shouldShowPreview: shouldShowPreview.

	self announce: anAnnouncement.
	
	^ anAnnouncement
]

{ #category : #'private - notifying' }
GtSpotter >> notifyStepPopped: aSpotterStep at: aStepIndex [
	<return: #GtSpotterStepPopped>
	| anAnnouncement |
	
	anAnnouncement := GtSpotterStepPopped new 
		spotterStep: aSpotterStep;
		stepIndex: aStepIndex.

	self announce: anAnnouncement.
	
	^ anAnnouncement
]

{ #category : #'private - notifying' }
GtSpotter >> notifyStepPushed: aSpotterStep [
	<return: #GtSpotterStepPushed>
	| anAnnouncement |
	
	anAnnouncement := GtSpotterStepPushed new 
		spotterStep: aSpotterStep.

	self announce: anAnnouncement.
	
	^ anAnnouncement
]

{ #category : #'api - steps' }
GtSpotter >> popStep [
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
GtSpotter >> popUntil: aSpotterStep [
	"Remove steps until a given step does not become the last one"

	[ steps last == aSpotterStep ]
		whileFalse: [ self popStep ]
]

{ #category : #'api - steps' }
GtSpotter >> popUntilIncluding: aSpotterStep [
	"Remove steps until a given step does not become the last one"

	[ steps last == aSpotterStep ]
		whileFalse: [ self popStep ].
	steps size > 1 ifTrue: [ self popStep ]
]

{ #category : #'api - steps' }
GtSpotter >> pushStep: anOriginObject [
	<return: #GtSpotterStep>
	| aNewStep shouldAsssignCurrentStep |
	
	aNewStep := GtSpotterStep new initializeWithSpotter: self origin: anOriginObject.
	steps add: aNewStep.

	shouldAsssignCurrentStep := currentStep isNil.
	shouldAsssignCurrentStep ifTrue: [ currentStep := aNewStep ].

	self notifyStepPushed: aNewStep.

	shouldAsssignCurrentStep ifTrue: [ self notifyCurrentStepChanged: aNewStep at: steps size ].
	
	^ aNewStep
]

{ #category : #'api - accessing' }
GtSpotter >> shouldShowPreview [
	^ shouldShowPreview
]

{ #category : #'api - accessing' }
GtSpotter >> showPreview [
	self showPreview: true
]

{ #category : #'api - accessing' }
GtSpotter >> showPreview: aBoolean [
	shouldShowPreview = aBoolean
		ifTrue: [ ^ self ].

	shouldShowPreview := aBoolean.
	self notifyPreviewStateChanged
]

{ #category : #'api - accessing' }
GtSpotter >> steps [
	^ steps
]

{ #category : #'api - actions' }
GtSpotter >> switchToDebugMode [
	isDebugMode := true.
	self notifyDebugModeChanged
]

{ #category : #'api - actions' }
GtSpotter >> switchToProductionMode [
	isDebugMode := false.
	self notifyDebugModeChanged
]

{ #category : #'api - accessing' }
GtSpotter >> togglePreview [
	self shouldShowPreview
		ifTrue: [ self hidePreview ]
		ifFalse: [ self showPreview ]
]

{ #category : #'api - announcer' }
GtSpotter >> unsubscribe: anObject [
	"Unsubscribe all subscriptions of anObject from the receiver"

	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#unsubscribeTemplate'>
	^ announcer ifNotNil: [ :anAnnouncer | anAnnouncer unsubscribe: anObject ]
]

{ #category : #'api - announcer' }
GtSpotter >> when: anAnnouncementClass do: aBlock [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ])
		when: anAnnouncementClass do: aBlock
]

{ #category : #'api - announcer' }
GtSpotter >> when: anAnnouncementClass do: aBlock for: aSubscriber [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenDoForTemplate'>
	^ (self when: anAnnouncementClass do: aBlock)
		subscriber: aSubscriber;
		yourself
]

{ #category : #'api - announcer' }
GtSpotter >> when: anAnnouncementClass send: aSelector to: anObject [
	<generatedFrom: #'TGtRobocoderAnnouncerTemplate>>#whenSendToTemplate'>
	^ (announcer ifNil: [ announcer := Announcer new ]) weak
		when: anAnnouncementClass send: aSelector to: anObject
]
