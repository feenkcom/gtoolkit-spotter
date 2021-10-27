Class {
	#name : #GtSpotterStartFilterSignal,
	#superclass : #GtSpotterFilterSignal,
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : #accessing }
GtSpotterStartFilterSignal >> name [
	^ 'Spotter Start Filter: ', self query asString
]
