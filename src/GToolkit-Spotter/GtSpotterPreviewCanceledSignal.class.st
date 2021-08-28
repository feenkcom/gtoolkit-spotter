Class {
	#name : 'GtSpotterPreviewCanceledSignal',
	#superclass : 'GtSpotterPreviewSignal',
	#instVars : [
		'newCandidate'
	],
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : 'accessing' }
GtSpotterPreviewCanceledSignal >> name [
	^ 'Preview canceled: ', self item asString, ' by ', self newItem.
]

{ #category : 'accessing' }
GtSpotterPreviewCanceledSignal >> newCandidate [
	^ newCandidate
]

{ #category : 'accessing' }
GtSpotterPreviewCanceledSignal >> newCandidate: anObject [
	newCandidate := anObject
]

{ #category : 'accessing' }
GtSpotterPreviewCanceledSignal >> newItem [
	^ self newCandidate item
]
