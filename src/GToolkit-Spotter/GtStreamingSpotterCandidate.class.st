Class {
	#name : #GtStreamingSpotterCandidate,
	#superclass : #Object,
	#instVars : [
		'item',
		'search'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #testing }
GtStreamingSpotterCandidate >> isBroken [
	^ false
]

{ #category : #accessing }
GtStreamingSpotterCandidate >> item [

	^ item
]

{ #category : #initialization }
GtStreamingSpotterCandidate >> item: anObject search: aSearch [
	item := anObject.
	search := aSearch
]

{ #category : #printing }
GtStreamingSpotterCandidate >> printOn: aStream [
	"Append a sequence of characters to aStream that identify the receiver."

	super printOn: aStream.
	aStream
		nextPutAll: ' item: ';
		print: item
]

{ #category : #accessing }
GtStreamingSpotterCandidate >> search [

	^ search
]
