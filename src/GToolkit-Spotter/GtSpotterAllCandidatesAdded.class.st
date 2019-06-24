Class {
	#name : #GtSpotterAllCandidatesAdded,
	#superclass : #GTSpotterAnnouncement,
	#instVars : [
		'candidateLinks'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterAllCandidatesAdded >> candidateLinks [
	^ candidateLinks
]

{ #category : #accessing }
GtSpotterAllCandidatesAdded >> candidateLinks: anObject [
	candidateLinks := anObject
]
