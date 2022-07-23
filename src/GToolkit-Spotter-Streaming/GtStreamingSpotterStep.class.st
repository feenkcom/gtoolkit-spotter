Class {
	#name : #GtStreamingSpotterStep,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'spotter',
		'origin'
	],
	#category : #'GToolkit-Spotter-Streaming-Model'
}

{ #category : #initialization }
GtStreamingSpotterStep >> initializeWithSpotter: aStreamingSpotter origin: anObject [
	spotter := aStreamingSpotter.
	origin := anObject
]
