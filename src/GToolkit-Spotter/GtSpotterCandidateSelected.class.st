Class {
	#name : #GtSpotterCandidateSelected,
	#superclass : #Announcement,
	#instVars : [
		'candidateBrick'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterCandidateSelected >> itemBrick [
	^ candidateBrick
]

{ #category : #accessing }
GtSpotterCandidateSelected >> itemBrick: anObject [
	candidateBrick := anObject
]
