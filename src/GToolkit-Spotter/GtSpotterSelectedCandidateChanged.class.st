Class {
	#name : #GtSpotterSelectedCandidateChanged,
	#superclass : #Announcement,
	#instVars : [
		'eventType',
		'selected'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #'as yet unclassified' }
GtSpotterSelectedCandidateChanged >> asRecorderEvent [

	^ GTSpotterRecorderSelectedCandidateChangedEvent fromAnnouncement: self
]

{ #category : #accessing }
GtSpotterSelectedCandidateChanged >> eventType [
	^ eventType
]

{ #category : #accessing }
GtSpotterSelectedCandidateChanged >> eventType: anObject [
	eventType := anObject
]

{ #category : #accessing }
GtSpotterSelectedCandidateChanged >> select: anObject [
	selected := anObject
]

{ #category : #accessing }
GtSpotterSelectedCandidateChanged >> selected [
	^ selected
]
