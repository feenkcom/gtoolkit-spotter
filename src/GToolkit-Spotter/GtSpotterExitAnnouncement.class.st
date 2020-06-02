Class {
	#name : #GtSpotterExitAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'eventType'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterExitAnnouncement >> eventType [
	^ eventType
]

{ #category : #accessing }
GtSpotterExitAnnouncement >> eventType: anObject [
	eventType := anObject
]
