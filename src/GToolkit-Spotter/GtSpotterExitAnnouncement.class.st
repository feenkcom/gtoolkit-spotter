Class {
	#name : #GtSpotterExitAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'eventType'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #'as yet unclassified' }
GtSpotterExitAnnouncement >> asRecorderEvent [

	^ GTSpotterRecorderExitAnnouncementEvent fromAnnouncement: self
]

{ #category : #accessing }
GtSpotterExitAnnouncement >> eventType [
	^ eventType
]

{ #category : #accessing }
GtSpotterExitAnnouncement >> eventType: anObject [
	eventType := anObject
]
