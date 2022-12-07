Class {
	#name : #GtStreamingSpotterDebugModeChanged,
	#superclass : #GtStreamingSpotterAnnouncement,
	#instVars : [
		'isDebugMode'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtStreamingSpotterDebugModeChanged >> isDebugMode [
	^ isDebugMode
]

{ #category : #accessing }
GtStreamingSpotterDebugModeChanged >> isDebugMode: aBoolean [
	isDebugMode := aBoolean
]
