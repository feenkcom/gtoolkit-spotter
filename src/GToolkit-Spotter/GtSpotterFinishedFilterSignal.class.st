Class {
	#name : #GtSpotterFinishedFilterSignal,
	#superclass : #GtSpotterFilterSignal,
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : #testing }
GtSpotterFinishedFilterSignal class >> gtNormalOperationSignal [
	^ true
]

{ #category : #accessing }
GtSpotterFinishedFilterSignal >> name [
	^ 'Spotter Finished Filter: ', self query asString
]
