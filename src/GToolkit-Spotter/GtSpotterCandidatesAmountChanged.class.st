Class {
	#name : #GtSpotterCandidatesAmountChanged,
	#superclass : #GTSpotterAnnouncement,
	#instVars : [
		'amount'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterCandidatesAmountChanged >> amount [
	^ amount
]

{ #category : #accessing }
GtSpotterCandidatesAmountChanged >> amount: anObject [
	amount := anObject
]
