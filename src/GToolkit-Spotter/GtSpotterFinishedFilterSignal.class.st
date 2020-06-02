Class {
	#name : #GtSpotterFinishedFilterSignal,
	#superclass : #GtSpotterFilterSignal,
	#category : #'GToolkit-Spotter-Logging'
}

{ #category : #accessing }
GtSpotterFinishedFilterSignal >> name [
	^ 'Spotter Finished Filter: ', self query asString
]
