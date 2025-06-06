Class {
	#name : #GtStreamingSpotterPager,
	#superclass : #BrPager,
	#traits : 'TGtWithSpotter',
	#classTraits : 'TGtWithSpotter classTrait',
	#category : #'GToolkit-Spotter-UI-Elements'
}

{ #category : #initialization }
GtStreamingSpotterPager >> initialize [
	super initialize.

	self
		matchParent;
		background: self theme default contentBackground;
		layout: BlLinearLayout vertical;
		aptitude: BrScrollablePagerAptitude new
]

{ #category : #'private - event handling' }
GtStreamingSpotterPager >> onCurrentStepChanged: anAnnouncement [
	self smoothScrollTo: anAnnouncement stepIndex
]

{ #category : #'api - spotter' }
GtStreamingSpotterPager >> onSpotterChanged [
	"Is sent when a new spotter is assigned to the receiver.
	Note: #onSpotterChanged is sent before #subscribeToSpotter
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSpotterChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	spotter steps do: [ :eachStep | self pushStep: eachStep ]
]

{ #category : #'private - event handling' }
GtStreamingSpotterPager >> onStepAdded: anAnnouncement [
	"as soon as step added we need to push it"
	
	self pushStep: anAnnouncement spotterStep
]

{ #category : #'private - event handling' }
GtStreamingSpotterPager >> onStepRemoved: anAnnouncement [
	"as soon as step added we need to push it"
	
	self removePageAt: anAnnouncement stepIndex
]

{ #category : #'private - actions' }
GtStreamingSpotterPager >> pushStep: aSpotterStep [
	| aStepElement aPageModel aPageContainer |
	
	aStepElement := GtStreamingSpotterStepElement new
		spotterStep: aSpotterStep;
		id: (GtStreamingSpotterStepElementId indexed: self pages size + 1).
	
	aPageModel := BrPagerPageModel new.
	aPageModel model: aSpotterStep.
	
	aPageContainer := BlElement new.
	aPageContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	aPageContainer addChild: aStepElement.
	aPageContainer viewModel: aPageModel.
	
	self addPage: aPageContainer
]

{ #category : #'api - spotter' }
GtStreamingSpotterPager >> subscribeToSpotter [
	"Is sent after a new spotter is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSpotter if the receiver subscribes to them"
	<modelSubscriber: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	spotter when: GtSpotterStepPushed send: #onStepAdded: to: self.
	spotter when: GtSpotterStepPopped send: #onStepRemoved: to: self.
	spotter when: GtSpotterCurrentStepChanged send: #onCurrentStepChanged: to: self
]

{ #category : #'api - spotter' }
GtStreamingSpotterPager >> unsubscribeFromSpotter [
	"Is sent before a new spotter is assigned to the receiver.
	Objects that subscribe to spotter are required to implement this method."
	<modelUnsubscriber: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	spotter unsubscribe: self
]
