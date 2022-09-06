Class {
	#name : #GtStreamingSpotterElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtStreamingWithSpotter',
	#classTraits : 'TGtStreamingWithSpotter classTrait',
	#instVars : [
		'headerElement',
		'stepsPager'
	],
	#category : #'GToolkit-Spotter-Streaming-UI'
}

{ #category : #initialization }
GtStreamingSpotterElement >> initialize [
	super initialize.
	
	self matchParent.
	
	self background: Color white.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	
	headerElement := GtStreamingSpotterHeaderElement new.
	stepsPager := GtStreamingSpotterPager new.
	
	self addChildren: { headerElement . stepsPager }.
	
	self addShortcut: (BlShortcutWithAction new
		combination: (BlKeyCombination builder meta; key: BlKeyboardKey arrowRight; build);
		action: [ :anEvent :aShortcut | self halt ])
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
