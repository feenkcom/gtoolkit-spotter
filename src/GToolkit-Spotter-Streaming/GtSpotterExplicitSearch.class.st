Class {
	#name : #GtSpotterExplicitSearch,
	#superclass : #GtSpotterSearch,
	#instVars : [
		'searchComputation'
	],
	#category : #'GToolkit-Spotter-Streaming-Searches'
}

{ #category : #converting }
GtSpotterExplicitSearch >> asStreamFor: aSpotterContext [
	<return: #TAsyncStream>
	
	aSpotterContext isEmptySearchQuery
		ifTrue: [ ^ AsyncEmptyStream new ].
	
	^ searchComputation gtValue: aSpotterContext
]

{ #category : #printing }
GtSpotterExplicitSearch >> printOn: aStream [
	aStream
		nextPutAll: 'Explicit Search: ';
		nextPutAll: title
]

{ #category : #accessing }
GtSpotterExplicitSearch >> search: aBlock [
	searchComputation := aBlock
]
