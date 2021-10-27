"
I represent one search candidate produced by a spotter processor


"
Class {
	#name : #GtSpotterCandidate,
	#superclass : #Object,
	#instVars : [
		'processor',
		'item',
		'renderingProcessor'
	],
	#category : 'GToolkit-Spotter-Model - Candidates'
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
	^ (self renderingProcessor itemNameFor: self item) gtDisplayText.
]

{ #category : #accessing }
GtSpotterCandidate >> item [
	^ item
]

{ #category : #accessing }
GtSpotterCandidate >> item: anObject [
	item := anObject
]

{ #category : #printing }
GtSpotterCandidate >> previewElement [
	<return: #BlElement>
	^ self renderingProcessor previewElementFor: self previewObject.
]

{ #category : #printing }
GtSpotterCandidate >> previewObject [
	^ self renderingProcessor previewObjectFor: self item.
]

{ #category : #accessing }
GtSpotterCandidate >> processor [
	^ processor
]

{ #category : #accessing }
GtSpotterCandidate >> processor: anObject [
	processor ifNil: [ self renderingProcessor: anObject ].
	processor := anObject
]

{ #category : #accessing }
GtSpotterCandidate >> renderingProcessor [
	renderingProcessor ifNil: [ self renderingProcessor: processor ].
	^ renderingProcessor
]

{ #category : #accessing }
GtSpotterCandidate >> renderingProcessor: anObject [
	renderingProcessor := anObject
]
