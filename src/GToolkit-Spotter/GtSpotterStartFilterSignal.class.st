Class {
	#name : #GtSpotterStartFilterSignal,
	#superclass : #GtSpotterFilterSignal,
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : #testing }
GtSpotterStartFilterSignal class >> gtNormalOperationSignal [
	^ true
]

{ #category : #accessing }
GtSpotterStartFilterSignal >> name [
	^ 'Spotter Start Filter: ', self query asString
]
