Class {
	#name : #GtSpotterPreviewPreparationSignal,
	#superclass : #GtSpotterPreviewSignal,
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : #accessing }
GtSpotterPreviewPreparationSignal >> name [
	^ 'Preview preparation: ', self item asString
]
