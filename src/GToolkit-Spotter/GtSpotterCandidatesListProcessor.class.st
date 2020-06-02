Class {
	#name : #GtSpotterCandidatesListProcessor,
	#superclass : #GtSpotterCandidatesProcessor,
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
		'sortBlock',
		'previewObjectBlock',
		'previewElementBlock',
		'transformation'
	],
	#category : #'GToolkit-Spotter-Model - Processors'
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
GtSpotterCandidatesListProcessor >> actOn: anObject for: aStep from: aSpotterElement [
	
	actBlock
		ifNil: [ super actOn: anObject for: aStep from: aSpotterElement ]
		ifNotNil: [ actBlock cull: anObject cull: aStep cull: aSpotterElement ]
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

{ #category : #'gt-extension' }
GtSpotterCandidatesListProcessor >> gtAllCandidatesFor: aView [
	<gtView>
	allCandidates ifNil: [ ^ aView empty ].
	^ (allCandidates gtItemsFor: aView)
			title: 'All Candidates';
			priority: 1
]

{ #category : #'gt-extension' }
GtSpotterCandidatesListProcessor >> gtAllFilteredCandidatesFor: aView [
	<gtView>
	allFilteredCandidates ifNil: [ ^ aView empty ].
	^ (allFilteredCandidates gtItemsFor: aView)
			title: 'All Filtered Candidates';
			priority: 2
]

{ #category : #accessing }
GtSpotterCandidatesListProcessor >> gtDefiningMethodFor: aView [
	<gtView>
	self hasDefiningMethod ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Method';
		object: [ self definingMethod ];
		view: #gtSourceFor:

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
		ifFalse: [ (itemFilterNameBlock cull: anObject) asString ]
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
GtSpotterCandidatesListProcessor >> objectToActOn: anObject from: aStep [
	"Return an object that should be acted upon from a given step"
	<return: #Object>
	
	^ transformation
		ifNil: [ anObject ]
		ifNotNil: [ transformation cull: anObject cull: aStep ].
]

{ #category : #scripting }
GtSpotterCandidatesListProcessor >> previewElement: aBlockWithOneArgument [
	previewElementBlock := aBlockWithOneArgument
]

{ #category : #private }
GtSpotterCandidatesListProcessor >> previewElementFor: anObject [
	<return: #BlElement or: nil>
	^ previewElementBlock isNil
		ifTrue: [ super previewElementFor: anObject ]
		ifFalse: [ previewElementBlock cull: anObject ]
]

{ #category : #scripting }
GtSpotterCandidatesListProcessor >> previewObject: aBlockWithOneArgument [
	previewObjectBlock := aBlockWithOneArgument
]

{ #category : #private }
GtSpotterCandidatesListProcessor >> previewObjectFor: anObject [
	^ previewObjectBlock isNil
		ifTrue: [ super previewObjectFor: anObject ]
		ifFalse: [ previewObjectBlock cull: anObject ]
]

{ #category : #scripting }
GtSpotterCandidatesListProcessor >> send: aBlock [
	self
		assert: [ aBlock notNil ]
		description: [ 'Send transformation block must be non-nil'  ].
	aBlock isSymbol ifTrue: [ 
		self 
			assert: [ aBlock isUnary ]
			description: [ 'Send transformation symbol must be unary' ].
		transformation := [ :obj | aBlock value: obj ].
		^self ].
	self
		assert: [ aBlock numArgs <= 2 ]
		description: [ 'Send transformation block must have two or less arguments'  ].
	transformation := aBlock
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
