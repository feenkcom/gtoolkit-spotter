"
I represent one search candidate produced by a spotter porcessor
"
Class {
	#name : #GtSpotterCandidate,
	#superclass : #Object,
	#instVars : [
		'processor',
		'item'
	],
	#category : #'GToolkit-Spotter-Model - Candidates'
}

{ #category : #accessing }
GtSpotterCandidate >> children [
	^ {  }
]

{ #category : #printing }
GtSpotterCandidate >> gtDisplayOn: aStream [
	self item gtDisplayOn: aStream
]

{ #category : #printing }
GtSpotterCandidate >> gtDisplayText [
	^ self item gtDisplayText
]

{ #category : #accessing }
GtSpotterCandidate >> item [
	^ item
]

{ #category : #accessing }
GtSpotterCandidate >> item: anObject [
	item := anObject
]

{ #category : #accessing }
GtSpotterCandidate >> processor [
	^ processor
]

{ #category : #accessing }
GtSpotterCandidate >> processor: anObject [
	processor := anObject
]
