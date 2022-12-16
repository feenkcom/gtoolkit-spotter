Class {
	#name : #GtSpotterSearch,
	#superclass : #GtSpotterProtoSearch,
	#instVars : [
		'itemNameComputation',
		'actOnLogicComputation',
		'previewElementComputation',
		'itemsLimit',
		'actOnCategoryLogicComputation',
		'objectTransformation',
		'objectToolTransformation',
		'hasObjectAction',
		'categoryToolTransformation',
		'categoryTransformation',
		'hasCategoryAction'
	],
	#category : #'GToolkit-Spotter-Searches'
}

{ #category : #converting }
GtSpotterSearch >> asStreamFor: aSpotterContext [
	<return: #TAsyncStream>
	
	^ self subclassResponsibility
]

{ #category : #'api - configuration' }
GtSpotterSearch >> categoryActLogic: aBlockWithTwoArguments [
	self deprecated: ('Use {1} or {2}, otherwise handle {3} announcement to customize the act-on behavior' format: {
		(GtSpotterSearch >> #sendCategory:) selector printString.
		(GtSpotterSearch >> #sendToolCategory:) selector printString.
		GtSpotterCategoryActOn name
	}).

	actOnCategoryLogicComputation := aBlockWithTwoArguments
]

{ #category : #'private - computation' }
GtSpotterSearch >> categoryActOn: aCategory for: aSpotterStep from: anElement [
	self hasCategoryActOn
		ifFalse: [ ^ self ].

	actOnCategoryLogicComputation
		cull: aCategory
		cull: aSpotterStep
		cull: self
		cull: anElement
]

{ #category : #'private - computation' }
GtSpotterSearch >> categoryToActOn: anObject from: aSpotterStep [
	"Return an object that should be acted upon from a given step."
	<return: #Object>
	
	^ categoryTransformation
		cull: anObject
		cull: aSpotterStep
		cull: self
]

{ #category : #'private - computation' }
GtSpotterSearch >> categoryToolToActOn: aCategoryToSend rawCategory: aRawCategory from: aSpotterStep [
	"Return a tool that should be acted upon from a given step"
	<return: #GtPhlowTool>

	^ categoryToolTransformation
		cull: aCategoryToSend
		cull: aRawCategory
		cull: aSpotterStep
		cull: self
]

{ #category : #accessing }
GtSpotterSearch >> hasCategoryActOn [
	^ hasCategoryAction or: [ actOnCategoryLogicComputation isNotNil ]
]

{ #category : #accessing }
GtSpotterSearch >> hasObjectAction [
	^ hasObjectAction or: [ actOnLogicComputation isNotNil ]
]

{ #category : #initialization }
GtSpotterSearch >> initialize [
	super initialize.

	itemsLimit := 5.

	objectTransformation := [ :anObject :aStep :aSearch | anObject ].
	objectToolTransformation := [ :anObjectToSend :aRawObject :aStep :aSearch |
		anObjectToSend gtDefaultInspectorTool ].
	categoryTransformation  := [ :anObject :aStep | anObject ].
	categoryToolTransformation := [ :aCategoryToSend :aRawCategory :aStep :aSearch | 
		aCategoryToSend gtDefaultInspectorTool ].

	hasObjectAction := true.
	hasCategoryAction := true.

	actOnLogicComputation := [ :anObject :aSpotterStep :aSpotterSearch :anElement |
		anObject gtSpotterActDefault: aSpotterStep from: anElement ].
	actOnCategoryLogicComputation := [ :aCategory :aSpotterStep :aSpotterSearch :anElement |
		aCategory gtSpotterActDefault: aSpotterStep from: anElement ]
]

{ #category : #'api - configuration' }
GtSpotterSearch >> itemActLogic: aBlockWithTwoArguments [
	self deprecated: ('Use {1} or {2}, otherwise handle {3} announcement to customize the act-on behavior' format: {
		(GtSpotterSearch >> #send:) selector printString.
		(GtSpotterSearch >> #sendTool:) selector printString.
		GtSpotterObjectActOn name
	}).

	actOnLogicComputation := aBlockWithTwoArguments
]

{ #category : #'api - configuration' }
GtSpotterSearch >> itemName: aBlockWithOneArgument [
	itemNameComputation := aBlockWithOneArgument
]

{ #category : #'private - computation' }
GtSpotterSearch >> itemNameFor: anObject [
	<return: #String or: #BlText>

	^ itemNameComputation 
		ifNil: [ anObject gtDisplayText ]
		ifNotNil: [ :aBlock | aBlock cull: anObject ]
]

{ #category : #accessing }
GtSpotterSearch >> itemsLimit [
	^ itemsLimit
]

{ #category : #'api - configuration' }
GtSpotterSearch >> itemsLimit: anInteger [
	itemsLimit := anInteger
]

{ #category : #'private - computation' }
GtSpotterSearch >> objectActOn: anObject for: aSpotterStep from: anElement [
	self hasObjectAction
		ifFalse: [ ^ self ].

	actOnLogicComputation
		cull: anObject
		cull: aSpotterStep
		cull: self
		cull: anElement
]

{ #category : #'private - computation' }
GtSpotterSearch >> objectToActOn: anObject from: aSpotterStep [
	"Return an object that should be acted upon from a given step."
	<return: #Object>
	
	^ objectTransformation
		cull: anObject
		cull: aSpotterStep
		cull: self
]

{ #category : #'private - computation' }
GtSpotterSearch >> objectToolToActOn: anObjectToSend rawObject: aRawObject from: aSpotterStep [
	"Return a tool that should be acted upon from a given step"
	<return: #GtPhlowTool>

	^ objectToolTransformation
		cull: anObjectToSend
		cull: aRawObject
		cull: aSpotterStep
		cull: self
]

{ #category : #'api - configuration' }
GtSpotterSearch >> previewElement: aBlockWithOneArgument [
	previewElementComputation := aBlockWithOneArgument
]

{ #category : #'private - computation' }
GtSpotterSearch >> previewObjectFor: anObject [
	^ anObject
]

{ #category : #'api - configuration' }
GtSpotterSearch >> send: aBlock [
	objectTransformation := aBlock
]

{ #category : #'api - configuration' }
GtSpotterSearch >> sendCategory: aBlock [
	categoryTransformation := aBlock
]

{ #category : #'api - configuration' }
GtSpotterSearch >> sendCategoryTool: aBlock [
	categoryToolTransformation := aBlock
]

{ #category : #'api - configuration' }
GtSpotterSearch >> sendTool: aBlock [
	objectToolTransformation := aBlock
]

{ #category : #'api - configuration' }
GtSpotterSearch >> withoutCategoryAction [
	actOnCategoryLogicComputation := nil.
	hasCategoryAction := false
]

{ #category : #'api - configuration' }
GtSpotterSearch >> withoutItemAction [
	actOnLogicComputation := nil.
	hasObjectAction := false
]

{ #category : #'api - configuration' }
GtSpotterSearch >> withoutItemsLimit [
	self itemsLimit: Float infinity
]
