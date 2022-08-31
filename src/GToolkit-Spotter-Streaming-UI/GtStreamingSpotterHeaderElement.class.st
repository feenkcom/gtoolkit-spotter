Class {
	#name : #GtStreamingSpotterHeaderElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtStreamingWithSpotter',
	#classTraits : 'TGtStreamingWithSpotter classTrait',
	#instVars : [
		'searchField',
		'breadcrumb'
	],
	#category : #'GToolkit-Spotter-Streaming-UI'
}

{ #category : #initialization }
GtStreamingSpotterHeaderElement >> initialize [
	super initialize.
	
	self hMatchParent.
	self vFitContent.
	
	breadcrumb := GtStreamingSpotterBreadcrumb new.
	breadcrumb background: self theme header secondaryBackgroundColor.

	searchField := GtStreamingSpotterSearchField new.
	searchField
		vFitContent;
		hMatchParent;
		padding: (BlInsets all: 15).
	
	self addChildren: {
		breadcrumb.
		searchField.
		(BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical exact: 1 ];
			background: self theme header secondaryBackgroundColor)
	}
]

{ #category : #'api - spotter' }
GtStreamingSpotterHeaderElement >> onSpotterChanged [
	"Is sent when a new spotter is assigned to the receiver.
	Note: #onSpotterChanged is sent before #subscribeToSpotter
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSpotterChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	searchField spotter: spotter.
	breadcrumb spotter: spotter.
]

{ #category : #accessing }
GtStreamingSpotterHeaderElement >> searchField [
	^ searchField
]
