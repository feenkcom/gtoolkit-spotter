Class {
	#name : #GtSpotterPreviewReadySignal,
	#superclass : #GtSpotterPreviewSignal,
	#instVars : [
		'previewElement',
		'text'
	],
	#category : #'GToolkit-Spotter-Logging'
}

{ #category : #accessing }
GtSpotterPreviewReadySignal >> name [
	^ 'Preview ready: ', self item asString
]

{ #category : #accessing }
GtSpotterPreviewReadySignal >> previewElement [
	^ previewElement
]

{ #category : #accessing }
GtSpotterPreviewReadySignal >> previewElement: anObject [
	previewElement := anObject
]

{ #category : #accessing }
GtSpotterPreviewReadySignal >> text [
	^ text
]

{ #category : #accessing }
GtSpotterPreviewReadySignal >> text: anObject [
	text := anObject
]
