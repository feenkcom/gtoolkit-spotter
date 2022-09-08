Class {
	#name : #GtSpotterProtoSearch,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Streaming-Searches'
}

{ #category : #accessing }
GtSpotterProtoSearch >> explicit [
	^ GtSpotterExplicitSearch new
]

{ #category : #accessing }
GtSpotterProtoSearch >> list [
	^ GtSpotterListSearch new
]
