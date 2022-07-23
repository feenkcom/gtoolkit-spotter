Class {
	#name : #GtSpotterStreamingContext,
	#superclass : #Object,
	#instVars : [
		'searchQuery'
	],
	#category : #'GToolkit-Spotter-Streaming-Model'
}

{ #category : #accessing }
GtSpotterStreamingContext >> searchQuery [

	^ searchQuery
]

{ #category : #accessing }
GtSpotterStreamingContext >> searchQuery: anObject [
	searchQuery := anObject
]
