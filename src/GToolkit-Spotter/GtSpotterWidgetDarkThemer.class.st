Class {
	#name : #GtSpotterWidgetDarkThemer,
	#superclass : #GTSpotterWidgetThemer,
	#category : #'GToolkit-Spotter-Theme'
}

{ #category : #values }
GtSpotterWidgetDarkThemer >> backgroundColor [
	"used as background color for all panes"
	^ Color r: 0.25 g: 0.25 b: 0.25
]

{ #category : #values }
GtSpotterWidgetDarkThemer >> borderColor [
	"color that is used for border and dividers of UI parts of Spotter
	for example divider between header and results or between preview and list"
	^ self backgroundColor darker
]

{ #category : #values }
GtSpotterWidgetDarkThemer >> itemActionSelectedBackgroundColor [

	^ self itemSelectedBackgroundColor slightlyDarker
]

{ #category : #values }
GtSpotterWidgetDarkThemer >> itemIconAlphaValue [

	^ 0.5
]

{ #category : #values }
GtSpotterWidgetDarkThemer >> itemSelectedBackgroundColor [

	^ self backgroundColor slightlyDarker
]

{ #category : #values }
GtSpotterWidgetDarkThemer >> searchFieldTextColor [
	
	^ Color white slightlyDarker
]

{ #category : #values }
GtSpotterWidgetDarkThemer >> titleTextColor [

	^ self backgroundColor muchLighter
]
