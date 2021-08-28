Class {
	#name : 'GtSpotterPreviewStartSignal',
	#superclass : 'GtSpotterPreviewSignal',
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : 'accessing' }
GtSpotterPreviewStartSignal >> name [
	^ 'Preview start: ', self item asString
]
