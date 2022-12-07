Trait {
	#name : #TGtStreamingWithSpotter,
	#instVars : [
		'spotter'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #'api - spotter' }
TGtStreamingWithSpotter >> hasSpotter [
	"Return a true if nil is assigned to the receiver, false otherwise"
	<return: #Boolean>
	<modelTester: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#hasObjectTemplate'>

	^ spotter notNil
]

{ #category : #'api - spotter' }
TGtStreamingWithSpotter >> onPostSpotterChanged [
	"I am an optional hook method that is sent after #subscribeToSpotter.
	I do nothing by default but allow users to perform update operations when a receiver object is already
	subscribed to announcements."
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onPostObjectChangedTemplate'>
]

{ #category : #'api - spotter' }
TGtStreamingWithSpotter >> onSpotterChanged [
	"Is sent when a new spotter is assigned to the receiver.
	Note: #onSpotterChanged is sent before #subscribeToSpotter
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSpotterChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
]

{ #category : #'api - spotter' }
TGtStreamingWithSpotter >> spotter [
	"Return a not-null spotter assigned to the receiver"
	<modelGetter: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectGetterTemplate'>
	self
		assert: [ spotter notNil ]
		description: [ 'spotter should be initialized' ].

	^ spotter
]

{ #category : #'api - spotter' }
TGtStreamingWithSpotter >> spotter: aSpotter [
	"Set a not-null spotter assigned to the receiver"
	<modelSetter: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#objectSetterTemplate'>
	self
		assert: [ aSpotter notNil ]
		description: [ 'spotter must not be nil' ].

	spotter == aSpotter
		ifTrue: [ ^ self ].

	spotter ifNotNil: [ self unsubscribeFromSpotter ].
	spotter := aSpotter.

	self onSpotterChanged.
	self subscribeToSpotter.
	self onPostSpotterChanged
]

{ #category : #'api - spotter' }
TGtStreamingWithSpotter >> subscribeToSpotter [
	"Is sent after a new spotter is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSpotter if the receiver subscribes to them"
	<modelSubscriber: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
]

{ #category : #'api - spotter' }
TGtStreamingWithSpotter >> unsubscribeFromSpotter [
	"Is sent before a new spotter is assigned to the receiver.
	Objects that subscribe to spotter are required to implement this method."
	<modelUnsubscriber: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
]
