Class {
	#name : #GtSpotterListSearch,
	#superclass : #GtSpotterSearch,
	#instVars : [
		'filterComputation',
		'itemsComputation'
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

{ #category : #initialization }
GtSpotterListSearch >> initialize [
	super initialize.
	
	filterComputation := [ :aSpotterContext |  ]
]

{ #category : #accessing }
GtSpotterListSearch >> items: aBlock [
	itemsComputation := aBlock
]
