Class {
	#name : #GtSpotterCandidatesListProcessor,
	#superclass : #GTSpotterCandidatesProcessor,
	#instVars : [
		'allCandidatesBlock',
		'candidatesLimit',
		'queryMatchingBlock',
		'title',
		'itemNameBlock',
		'itemIconBlock',
		'actBlock',
		'wantsToDisplayOnEmptyQuery',
		'filterBlock',
		'itemFilterNameBlock',
		'keyBinding',
		'sortBlock'
	],
	#category : #'GToolkit-Spotter-Processors'
}

{ #category : #accessing }
GtSpotterCandidatesListProcessor >> actLogic [
	^ actBlock
]

{ #category : #scripting }
GtSpotterCandidatesListProcessor >> actLogic: aBlockWithTwoArguments [

	actBlock := aBlockWithTwoArguments
]

{ #category : #private }
GtSpotterCandidatesListProcessor >> actOn: anObject for: aStep [
	
	actBlock
		ifNil: [ super actOn: anObject for: aStep ]
		ifNotNil: [ actBlock cull: anObject cull: aStep ]
]

{ #category : #compatibility }
GtSpotterCandidatesListProcessor >> allCandidates: aBlockWithOneArgument [
	self items: aBlockWithOneArgument
]

{ #category : #compatibility }
GtSpotterCandidatesListProcessor >> candidatesLimit: anInteger [
	self itemsLimit: anInteger
]

{ #category : #private }
GtSpotterCandidatesListProcessor >> computeAllItemsIn: aContext [
	^ allCandidatesBlock cull: aContext
]

{ #category : #compatibility }
GtSpotterCandidatesListProcessor >> defaultCandidatesLimit [
	^ self defaultItemsLimit
]

{ #category : #'accessing-defaults' }
GtSpotterCandidatesListProcessor >> defaultContinueItemsLimit [
	" Spotter becomes extraordenary slow when rendering too many results. So we set the maximum limit to 100. This is only a temporary solution until we have fixed the problem. Until then no spotter processor will ever generate more then 100 results. "
	^ 100
]

{ #category : #'accessing-defaults' }
GtSpotterCandidatesListProcessor >> defaultItemsLimit [
	^ 5
]

{ #category : #private }
GtSpotterCandidatesListProcessor >> doFilterInContext: aSpotterContext [
	^ aSpotterContext doFilter: filterBlock gtFilter forProcessor: self
]

{ #category : #accessing }
GtSpotterCandidatesListProcessor >> filter [
	^ filterBlock
]

{ #category : #scripting }
GtSpotterCandidatesListProcessor >> filter: aGTFilterOrBlockWithOneArgument [
	filterBlock := aGTFilterOrBlockWithOneArgument 
]

{ #category : #scripting }
GtSpotterCandidatesListProcessor >> filter: aGTFilter item: aGtSpotterIterator [ 
	self filter: aGTFilter.
	self items: aGtSpotterIterator gtIterator.
	
]

{ #category : #compatibility }
GtSpotterCandidatesListProcessor >> filterUsing: aFilter [
	self filter: aFilter
]

{ #category : #testing }
GtSpotterCandidatesListProcessor >> hasDynamicItems [
	^ allCandidatesBlock hasDynamicItems
]

{ #category : #accessing }
GtSpotterCandidatesListProcessor >> itemFilterName [
	^ itemFilterNameBlock
]

{ #category : #scripting }
GtSpotterCandidatesListProcessor >> itemFilterName: aBlockWithOneArgument [
	itemFilterNameBlock := aBlockWithOneArgument
]

{ #category : #private }
GtSpotterCandidatesListProcessor >> itemFilterNameFor: anObject [
	^ itemFilterNameBlock isNil
		ifTrue: [ super itemFilterNameFor: anObject ]
		ifFalse: [ itemFilterNameBlock cull: anObject ]
]

{ #category : #accessing }
GtSpotterCandidatesListProcessor >> itemIcon [
	^ itemIconBlock
]

{ #category : #scripting }
GtSpotterCandidatesListProcessor >> itemIcon: aBlockWithOneArgument [
	itemIconBlock := aBlockWithOneArgument
]

{ #category : #private }
GtSpotterCandidatesListProcessor >> itemIconFor: anObject [
	^ itemIconBlock isNil
		ifTrue: [ super itemIconFor: anObject ]
		ifFalse: [ itemIconBlock cull: anObject ]
]

{ #category : #accessing }
GtSpotterCandidatesListProcessor >> itemName [
	^ itemNameBlock
]

{ #category : #scripting }
GtSpotterCandidatesListProcessor >> itemName: aBlockWithOneArgument [
	itemNameBlock := aBlockWithOneArgument
]

{ #category : #private }
GtSpotterCandidatesListProcessor >> itemNameFor: anObject [
	^ itemNameBlock isNil
		ifTrue: [ super itemNameFor: anObject ]
		ifFalse: [ itemNameBlock cull: anObject ]
]

{ #category : #scripting }
GtSpotterCandidatesListProcessor >> items: aBlock [
	allCandidatesBlock := aBlock
]

{ #category : #accessing }
GtSpotterCandidatesListProcessor >> itemsLimit [
	^ candidatesLimit ifNil: [ self defaultItemsLimit ]
]

{ #category : #scripting }
GtSpotterCandidatesListProcessor >> itemsLimit: anInteger [
	candidatesLimit := anInteger
]

{ #category : #accessing }
GtSpotterCandidatesListProcessor >> keyBinding [
	^ keyBinding
]

{ #category : #accessing }
GtSpotterCandidatesListProcessor >> keyBinding: anObject [
	keyBinding := anObject
]

{ #category : #'scripting-convenience' }
GtSpotterCandidatesListProcessor >> match: aBlockWithTwoArguments [
	self filter: (GTFilterBlock new 
		matcher: aBlockWithTwoArguments;
		yourself)
]

{ #category : #'scripting-convenience' }
GtSpotterCandidatesListProcessor >> matchAlike [
	self filter: GTFilterAlike
]

{ #category : #'scripting-convenience' }
GtSpotterCandidatesListProcessor >> matchRegex [
	self filter: GTFilterRegex
]

{ #category : #'scripting-convenience' }
GtSpotterCandidatesListProcessor >> matchString [
	self filter: GTFilterStringMatch
]

{ #category : #'scripting-convenience' }
GtSpotterCandidatesListProcessor >> matchSubstring [
	self filter: GTFilterSubstring
]

{ #category : #'scripting-convenience' }
GtSpotterCandidatesListProcessor >> matchSubstrings [
	self filter: GTFilterSubstrings
]

{ #category : #accessing }
GtSpotterCandidatesListProcessor >> sort [
	^ sortBlock
]

{ #category : #scripting }
GtSpotterCandidatesListProcessor >> sort: aBlockWithTwoArguments [
	sortBlock := aBlockWithTwoArguments
]

{ #category : #accessing }
GtSpotterCandidatesListProcessor >> title [
	^ title ifNil: [ super title ]
]

{ #category : #scripting }
GtSpotterCandidatesListProcessor >> title: aString [
	title := aString
]

{ #category : #accessing }
GtSpotterCandidatesListProcessor >> wantsToDisplayOnEmptyQuery [
	^ wantsToDisplayOnEmptyQuery ifNil: [ super wantsToDisplayOnEmptyQuery ]
]

{ #category : #scripting }
GtSpotterCandidatesListProcessor >> wantsToDisplayOnEmptyQuery: anObject [
	wantsToDisplayOnEmptyQuery := anObject
]

{ #category : #private }
GtSpotterCandidatesListProcessor >> withItemsLimit: aLimit do: aBlock [
	| previousCandidatesLimit |
	previousCandidatesLimit := candidatesLimit.
	^ [ candidatesLimit := aLimit. aBlock value ] 
		ensure: [ candidatesLimit := previousCandidatesLimit ]
]
