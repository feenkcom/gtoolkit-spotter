Class {
	#name : #GtSpotterExplicitSearch,
	#superclass : #GtSpotterSearch,
	#instVars : [
		'searchComputation',
		'wantsToDisplayOnEmptyQuery'
	],
	#category : #'GToolkit-Spotter-Streaming-Searches'
}

{ #category : #converting }
GtSpotterExplicitSearch >> asStreamFor: aSpotterContext [
	<return: #TAsyncStream>

	(aSpotterContext isEmptySearchQuery and: [ self wantsToDisplayOnEmptyQuery not ])
		ifTrue: [ ^ AsyncEmptyStream new ].

	^ (searchComputation gtValue: aSpotterContext) asAsyncStream
]

{ #category : #initialization }
GtSpotterExplicitSearch >> initialize [
	super initialize.

	wantsToDisplayOnEmptyQuery := false
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

{ #category : #accessing }
GtSpotterExplicitSearch >> wantsToDisplayOnEmptyQuery [
	^ wantsToDisplayOnEmptyQuery
]

{ #category : #accessing }
GtSpotterExplicitSearch >> wantsToDisplayOnEmptyQuery: aBoolean [
	wantsToDisplayOnEmptyQuery := aBoolean
]
