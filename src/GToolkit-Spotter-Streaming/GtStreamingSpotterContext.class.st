Class {
	#name : #GtStreamingSpotterContext,
	#superclass : #Object,
	#instVars : [
		'searchQuery'
	],
	#category : #'GToolkit-Spotter-Streaming-Model'
}

{ #category : #accessing }
GtStreamingSpotterContext >> searchQuery [

	^ searchQuery
]

{ #category : #accessing }
GtStreamingSpotterContext >> searchQuery: anObject [
	searchQuery := anObject
]