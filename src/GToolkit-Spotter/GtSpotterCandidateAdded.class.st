Class {
	#name : #GtSpotterCandidateAdded,
	#superclass : #GlamorousAuthor,
	#instVars : [
		'candidate'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterCandidateAdded >> candidate [
	^ candidate value
]

{ #category : #accessing }
GtSpotterCandidateAdded >> candidateLink [

	^ candidate
]

{ #category : #accessing }
GtSpotterCandidateAdded >> candidateLink: anObject [
	candidate := anObject
]
