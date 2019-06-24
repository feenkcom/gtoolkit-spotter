Class {
	#name : #GtSpotterCandidateAdded,
	#superclass : #GTSpotterAnnouncement,
	#instVars : [
		'candidateLink'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterCandidateAdded >> candidate [
	^ candidateLink value
]

{ #category : #accessing }
GtSpotterCandidateAdded >> candidateLink [

	^ candidateLink
]

{ #category : #accessing }
GtSpotterCandidateAdded >> candidateLink: anObject [
	candidateLink := anObject
]
