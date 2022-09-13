Class {
	#name : #GtStreamingSpotterModeChanged,
	#superclass : #GtStreamingSpotterAnnouncement,
	#instVars : [
		'isDebugMode'
	],
	#category : #'GToolkit-Spotter-Streaming-Events'
}

{ #category : #accessing }
GtStreamingSpotterModeChanged >> isDebugMode [
	^ isDebugMode
]

{ #category : #accessing }
GtStreamingSpotterModeChanged >> isDebugMode: aBoolean [
	isDebugMode := aBoolean
]
