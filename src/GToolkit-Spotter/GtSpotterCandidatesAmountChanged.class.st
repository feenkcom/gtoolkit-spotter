Class {
	#name : #GtSpotterCandidatesAmountChanged,
	#superclass : #GtSpotterAnnouncement,
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
