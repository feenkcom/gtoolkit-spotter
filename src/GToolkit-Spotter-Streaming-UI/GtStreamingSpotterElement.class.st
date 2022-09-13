Class {
	#name : #GtStreamingSpotterElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtStreamingWithSpotter',
	#classTraits : 'TGtStreamingWithSpotter classTrait',
	#instVars : [
		'headerElement',
		'stepsPager',
		'previewElement'
	],
	#category : #'GToolkit-Spotter-Streaming-UI'
}

{ #category : #'private - event handling' }
GtStreamingSpotterElement >> handleCategoryActOn: anEvent [
]

{ #category : #'private - event handling' }
GtStreamingSpotterElement >> handleDiveIn: anEvent [
	self spotter currentStep diveInItemDueTo: #keyPressedPrimaryArrowRight
]

{ #category : #'private - event handling' }
GtStreamingSpotterElement >> handleDiveOut: anEvent [
	self spotter currentStep  diveOutDueTo: #keyPressedPrimaryArrowLeft
]

{ #category : #'private - event handling' }
GtStreamingSpotterElement >> handleItemActOn: anEvent [
	self spotter currentStep
		actOnItemDueTo: #keyPressedReturn
		from: self
]

{ #category : #initialization }
GtStreamingSpotterElement >> initialize [
	super initialize.
	
	self matchParent.
	
	self background: Color white.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	
	headerElement := GtStreamingSpotterHeaderElement new.
	stepsPager := GtStreamingSpotterPager new.
	previewElement := GtStreamingSpotterPreviewElement new.
	
	self addChildren: {
		headerElement.
		BrHorizontalPane new
			matchParent;
			addChildren: {
				stepsPager .
				BlElement new
					background: self theme header secondaryBackgroundColor;
					constraintsDo: [ :c |
						c horizontal exact: 1.
						c vertical matchParent ].
				previewElement } }.
	
	self addShortcut: (BlShortcutWithAction new
		overrideChildren: true;
		combination: BlKeyCombination primaryArrowRight;
		action: [ :anEvent :aShortcut | self handleDiveIn: anEvent ]).
		
	self addShortcut: (BlShortcutWithAction new
		overrideChildren: true;
		combination: BlKeyCombination primaryArrowLeft;
		action: [ :anEvent :aShortcut | self handleDiveOut: anEvent ]).
		
	self addShortcut: (BlShortcutWithAction new
		overrideChildren: true;
		combination: BlKeyCombination return;
		action: [ :anEvent :aShortcut | self handleItemActOn: anEvent ]).
		
	self addShortcut: (BlShortcutWithAction new
		overrideChildren: true;
		combination: BlKeyCombination primaryReturn;
		action: [ :anEvent :aShortcut | self handleCategoryActOn: anEvent ]).

	self when: BlKeyDownEvent do: [ :anEvent |
		anEvent key isPrimary
			ifTrue: [ spotter switchToDebugMode ] ].

	self when: BlKeyUpEvent do: [ :anEvent |
		anEvent key isPrimary
			ifTrue: [ spotter switchToProductionMode ] ].
]

{ #category : #'private - event handling' }
GtStreamingSpotterElement >> onItemSelected: anAnnouncement [
	previewElement
		updatePreviewOf: anAnnouncement selected
		forSearch: anAnnouncement search
]

{ #category : #'api - spotter' }
GtStreamingSpotterElement >> onSpotterChanged [
	"Is sent when a new spotter is assigned to the receiver.
	Note: #onSpotterChanged is sent before #subscribeToSpotter
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSpotterChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	headerElement spotter: spotter.
	stepsPager spotter: spotter
]

{ #category : #'api - spotter' }
GtStreamingSpotterElement >> subscribeToSpotter [
	"Is sent after a new spotter is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSpotter if the receiver subscribes to them"
	<modelSubscriber: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	spotter when: GtSpotterSelectedCandidateChanged send: #onItemSelected: to: self
]

{ #category : #'api - spotter' }
GtStreamingSpotterElement >> unsubscribeFromSpotter [
	"Is sent before a new spotter is assigned to the receiver.
	Objects that subscribe to spotter are required to implement this method."
	<modelUnsubscriber: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	spotter unsubscribe: self
]
