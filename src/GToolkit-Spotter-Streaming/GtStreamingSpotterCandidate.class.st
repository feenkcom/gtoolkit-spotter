Class {
	#name : #GtStreamingSpotterCandidate,
	#superclass : #Object,
	#instVars : [
		'item',
		'search'
	],
	#category : #'GToolkit-Spotter-Streaming-Model'
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

{ #category : #accessing }
GtStreamingSpotterCandidate >> search [

	^ search
]
