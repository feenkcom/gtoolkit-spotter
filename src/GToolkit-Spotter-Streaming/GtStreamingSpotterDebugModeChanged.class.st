Class {
	#name : #GtStreamingSpotterDebugModeChanged,
	#superclass : #GtStreamingSpotterAnnouncement,
	#instVars : [
		'isDebugMode'
	],
	#category : #'GToolkit-Spotter-Streaming-Events'
}

{ #category : #accessing }
GtStreamingSpotterDebugModeChanged >> isDebugMode [
	^ isDebugMode
]

{ #category : #accessing }
GtStreamingSpotterDebugModeChanged >> isDebugMode: aBoolean [
	isDebugMode := aBoolean
]
