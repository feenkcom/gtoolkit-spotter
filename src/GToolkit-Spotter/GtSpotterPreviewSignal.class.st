Class {
	#name : #GtSpotterPreviewSignal,
	#superclass : #GtSpotterSignal,
	#instVars : [
		'context',
		'candidate'
	],
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : #accessing }
GtSpotterPreviewSignal >> candidate [
	^ candidate
]

{ #category : #accessing }
GtSpotterPreviewSignal >> candidate: anObject [
	candidate := anObject
]

{ #category : #accessing }
GtSpotterPreviewSignal >> context [
	^ context
]

{ #category : #accessing }
GtSpotterPreviewSignal >> context: anObject [
	context := anObject
]

{ #category : #testing }
GtSpotterPreviewSignal >> isPreviewSignal [
	^ true
]

{ #category : #accessing }
GtSpotterPreviewSignal >> item [
	^ self candidate item
]
