Class {
	#name : #GtStreamingSpotterSearchField,
	#superclass : #BrEditor,
	#traits : 'TGtWithSpotter',
	#classTraits : 'TGtWithSpotter classTrait',
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #initialization }
GtStreamingSpotterSearchField >> initialize [
	super initialize.

	self aptitude: (BrGlamorousRegularEditorAptitude new fontSize: 18).
	self requestFocus.
	
	self editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | spotter currentStep searchQuery: anEvent currentTarget text asString ]
]

{ #category : #'private - event handling' }
GtStreamingSpotterSearchField >> onCurrentStepChanged: anAnnouncement [
	self text: anAnnouncement spotterStep searchQuery.
	self requestFocus
]

{ #category : #'api - spotter' }
GtStreamingSpotterSearchField >> onSpotterChanged [
	"Is sent when a new spotter is assigned to the receiver.
	Note: #onSpotterChanged is sent before #subscribeToSpotter
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSpotterChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>

	self text: spotter currentStep searchQuery
]

{ #category : #'api - spotter' }
GtStreamingSpotterSearchField >> subscribeToSpotter [
	"Is sent after a new spotter is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSpotter if the receiver subscribes to them"
	<modelSubscriber: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	spotter when: GtStreamingSpotterCurrentStepChanged send: #onCurrentStepChanged: to: self
]

{ #category : #'api - spotter' }
GtStreamingSpotterSearchField >> unsubscribeFromSpotter [
	"Is sent before a new spotter is assigned to the receiver.
	Objects that subscribe to spotter are required to implement this method."
	<modelUnsubscriber: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	spotter unsubscribe: self
]
