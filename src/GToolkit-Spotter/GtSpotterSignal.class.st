Class {
	#name : #GtSpotterSignal,
	#superclass : #BeaconSignal,
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : #testing }
GtSpotterSignal class >> gtNormalOperationSignal [
	"Answer a Boolean indicating whether this signal is generated as part of normal operations.
	See {{gtMethod:BeaconSignal class>>gtNormalOperationSignal}} for a description"

	^ true.
]

{ #category : #testing }
GtSpotterSignal >> isFilterSignal [
	^ false
]

{ #category : #testing }
GtSpotterSignal >> isPreviewSignal [
	^ false
]
