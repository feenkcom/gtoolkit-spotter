Class {
	#name : #GtSpotterCandidateDeselected,
	#superclass : #Announcement,
	#instVars : [
		'candidate'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterCandidateDeselected >> candidate [
	^ candidate
]

{ #category : #accessing }
GtSpotterCandidateDeselected >> candidate: anObject [
	candidate := anObject
]
