Class {
	#name : #GtSpotterCandidateSelectedMoved,
	#superclass : #Announcement,
	#instVars : [
		'candidateBrick'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterCandidateSelectedMoved >> itemBrick [
	^ candidateBrick
]

{ #category : #accessing }
GtSpotterCandidateSelectedMoved >> itemBrick: anObject [
	candidateBrick := anObject
]
