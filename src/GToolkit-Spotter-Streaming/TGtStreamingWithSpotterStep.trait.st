Trait {
	#name : #TGtStreamingWithSpotterStep,
	#instVars : [
		'spotterStep'
	],
	#category : #'GToolkit-Spotter-Streaming-Model - Support'
}

{ #category : #'api - spotter step' }
TGtStreamingWithSpotterStep >> hasSpotterStep [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #spotterStep>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ spotterStep notNil
]

{ #category : #'api - spotter step' }
TGtStreamingWithSpotterStep >> onPostSpotterStepChanged [
	"I am an optional hook method that is sent after #subscribeToSpotterStep.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - spotter step' }
TGtStreamingWithSpotterStep >> onSpotterStepChanged [
	"Is sent when a new spotterStep is assigned to the receiver.
	Note: #onSpotterStepChanged is sent before #subscribeToSpotterStep
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSpotterStepChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - spotter step' }
TGtStreamingWithSpotterStep >> spotterStep [
	"Return a not-null spotterStep assigned to the receiver"
	<modelGetter: #spotterStep>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ spotterStep notNil ]
		description: [ 'spotterStep should be initialized' ].

	^ spotterStep
]

{ #category : #'api - spotter step' }
TGtStreamingWithSpotterStep >> spotterStep: aSpotterStep [
	"Set a not-null spotterStep assigned to the receiver"
	<modelSetter: #spotterStep>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aSpotterStep notNil ]
		description: [ 'spotterStep must not be nil' ].

	spotterStep == aSpotterStep
		ifTrue: [ ^ self ].

	spotterStep ifNotNil: [ self unsubscribeFromSpotterStep ].
	spotterStep := aSpotterStep.

	self onSpotterStepChanged.
	self subscribeToSpotterStep.
	self onPostSpotterStepChanged
]

{ #category : #'api - spotter step' }
TGtStreamingWithSpotterStep >> subscribeToSpotterStep [
	"Is sent after a new spotterStep is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSpotterStep if the receiver subscribes to them"
	<modelSubscriber: #spotterStep>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - spotter step' }
TGtStreamingWithSpotterStep >> unsubscribeFromSpotterStep [
	"Is sent before a new spotterStep is assigned to the receiver.
	Objects that subscribe to spotterStep are required to implement this method."
	<modelUnsubscriber: #spotterStep>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
