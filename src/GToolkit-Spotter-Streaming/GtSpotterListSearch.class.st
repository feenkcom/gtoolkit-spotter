Class {
	#name : #GtSpotterListSearch,
	#superclass : #GtSpotterSearch,
	#instVars : [
		'filterComputation',
		'itemsComputation',
		'wantsToDisplayOnEmptyQuery'
	],
	#category : #'GToolkit-Spotter-Streaming-Searches'
}

{ #category : #converting }
GtSpotterListSearch >> asStreamFor: aSpotterContext [
	<return: #TAsyncStream>
	| theScopeStream theSearchFilter |
	
	theScopeStream := (itemsComputation gtValue: aSpotterContext) asAsyncStream.
	(aSpotterContext isEmptySearchQuery and: [ self wantsToDisplayOnEmptyQuery ])
		ifTrue: [ ^ theScopeStream ].
	
	theSearchFilter := filterComputation gtValue: aSpotterContext.
	
	^ theSearchFilter applyInScope: theScopeStream context: aSpotterContext
]

{ #category : #accessing }
GtSpotterListSearch >> filter: aFilterOrBlock [
	filterComputation := aFilterOrBlock
]

{ #category : #accessing }
GtSpotterListSearch >> filterBySubstring [
	self filter: GtSpotterSubstringFilter new
]

{ #category : #initialization }
GtSpotterListSearch >> initialize [
	super initialize.
	
	filterComputation := [ :aSpotterContext |  ].
	wantsToDisplayOnEmptyQuery := true
]

{ #category : #accessing }
GtSpotterListSearch >> items: aBlock [
	itemsComputation := aBlock
]

{ #category : #printing }
GtSpotterListSearch >> printOn: aStream [
	aStream
		nextPutAll: 'List Search: ';
		nextPutAll: title
]

{ #category : #accessing }
GtSpotterListSearch >> wantsToDisplayOnEmptyQuery [
	^ wantsToDisplayOnEmptyQuery
]

{ #category : #'api - configuration' }
GtSpotterListSearch >> wantsToDisplayOnEmptyQuery: aBoolean [
	wantsToDisplayOnEmptyQuery := aBoolean
]
