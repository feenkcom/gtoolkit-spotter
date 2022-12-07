Class {
	#name : #GtSpotterDebugModeChanged,
	#superclass : #GtSpotterAnnouncement,
	#instVars : [
		'isDebugMode'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterDebugModeChanged >> isDebugMode [
	^ isDebugMode
]

{ #category : #accessing }
GtSpotterDebugModeChanged >> isDebugMode: aBoolean [
	isDebugMode := aBoolean
]
