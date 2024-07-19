Class {
	#name : #GtSpotterResizedEvent,
	#superclass : #BlEvent,
	#instVars : [
		'extent',
		'resizeTarget'
	],
	#category : #'GToolkit-Spotter-UI-Events'
}

{ #category : #accessing }
GtSpotterResizedEvent >> extent [
	^ extent
]

{ #category : #accessing }
GtSpotterResizedEvent >> extent: anObject [
	extent := anObject
]

{ #category : #accessing }
GtSpotterResizedEvent >> resizeTarget [
	^ resizeTarget
]

{ #category : #accessing }
GtSpotterResizedEvent >> resizeTarget: anObject [
	resizeTarget := anObject
]
