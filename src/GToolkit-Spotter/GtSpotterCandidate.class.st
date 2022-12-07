Class {
	#name : #GtSpotterCandidate,
	#superclass : #Object,
	#instVars : [
		'item',
		'search'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #testing }
GtSpotterCandidate >> isBroken [
	^ false
]

{ #category : #accessing }
GtSpotterCandidate >> item [

	^ item
]

{ #category : #initialization }
GtSpotterCandidate >> item: anObject search: aSearch [
	item := anObject.
	search := aSearch
]

{ #category : #printing }
GtSpotterCandidate >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' item: ';
		print: item
]

{ #category : #accessing }
GtSpotterCandidate >> search [

	^ search
]
