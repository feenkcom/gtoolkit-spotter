Class {
	#name : #GtSpotterPreviewFinishedSignal,
	#superclass : #GtSpotterPreviewSignal,
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : #accessing }
GtSpotterPreviewFinishedSignal >> name [
	^ 'Preview finished: ', self item asString
]
