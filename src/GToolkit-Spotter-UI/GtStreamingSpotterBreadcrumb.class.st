Class {
	#name : #GtStreamingSpotterBreadcrumb,
	#superclass : #BrBreadcrumb,
	#traits : 'TBrSelectable + TGtWithSpotter',
	#classTraits : 'TBrSelectable classTrait + TGtWithSpotter classTrait',
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #private }
GtStreamingSpotterBreadcrumb >> addStep: aNewStep [
	| aText |

	aText := aNewStep origin gtDisplayText.

	self addItem: (BrButton new
		aptitude: (BrGlamorousButtonRectangularAptitude + (BrGlamorousButtonLabelAptitude new selectedColor: Color black));
		action: [ spotter currentStep: aNewStep ];
		alignCenterLeft;
		label: aText)
]

{ #category : #initialization }
GtStreamingSpotterBreadcrumb >> initialize [
	super initialize.
	
	self viewModel add: (selectionModel := BrSelectionModel new).

	self aptitude: (BrBreadcrumbLinearAptitude new separator: [
		BrLabel new
			aptitude: (BrGlamorousLabelAptitude new thin foreground: Color gray);
			text: '>';
			margin: (BlInsets left: 5 right: 5) ]).

	self
		hMatchParent;
		vExact: 40;
		alignCenterLeft.

	self when: BrSelectionChanged do: [ :anEvent |
		anEvent withIndexDo: [ :anIndex :isSelected |
			 (self itemAt: anIndex) dispatchEvent: (BlElementSelectedStateWish selected: isSelected) ] ]
]

{ #category : #'api - selection' }
GtStreamingSpotterBreadcrumb >> maxSelectionIndex [
	<return: #Number>
	
	^ spotter amountOfSteps
]

{ #category : #'event handling' }
GtStreamingSpotterBreadcrumb >> onCurrentStepChanged: anAnnouncement [
	self selectOne: anAnnouncement stepIndex
]

{ #category : #'api - spotter' }
GtStreamingSpotterBreadcrumb >> onSpotterChanged [
	"Is sent when a new spotter is assigned to the receiver.
	Note: #onSpotterChanged is sent before #subscribeToSpotter
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSpotterChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	"remove steps first"
	self flag: #TODO.
	spotter steps do: [ :eachStep | self addStep: eachStep ].

	self selectOne: spotter currentStepIndex
]

{ #category : #'event handling' }
GtStreamingSpotterBreadcrumb >> onStepAdded: anAnnouncement [
	self addStep: anAnnouncement spotterStep
]

{ #category : #'event handling' }
GtStreamingSpotterBreadcrumb >> onStepRemoved: anAnnouncement [
	self removeItemAt: anAnnouncement stepIndex
]

{ #category : #'api - spotter' }
GtStreamingSpotterBreadcrumb >> subscribeToSpotter [
	"Is sent after a new spotter is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSpotter if the receiver subscribes to them"
	<modelSubscriber: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	spotter
		when: GtSpotterStepPushed send: #onStepAdded: to: self;
		when: GtSpotterStepPopped send: #onStepRemoved: to: self;
		when: GtSpotterCurrentStepChanged send: #onCurrentStepChanged: to: self
]

{ #category : #'api - spotter' }
GtStreamingSpotterBreadcrumb >> unsubscribeFromSpotter [
	"Is sent before a new spotter is assigned to the receiver.
	Objects that subscribe to spotter are required to implement this method."
	<modelUnsubscriber: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	spotter unsubscribe: self
]
