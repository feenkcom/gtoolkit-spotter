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
		'hasObjectAction'
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
	actOnCategoryLogicComputation := aBlockWithTwoArguments
]

{ #category : #'private - computation' }
GtSpotterSearch >> categoryActOn: aCategory for: aSpotterStep from: anElement [
	^ actOnCategoryLogicComputation
		ifNil: [ aCategory ]
		ifNotNil: [ :aBlock | aBlock cull: aCategory cull: aSpotterStep cull: anElement ]
]

{ #category : #accessing }
GtSpotterSearch >> hasCategoryActOn [
	^ actOnCategoryLogicComputation isNotNil
]

{ #category : #accessing }
GtSpotterSearch >> hasObjectAction [
	^ hasObjectAction or: [ actOnLogicComputation isNotNil ]
]

{ #category : #initialization }
GtSpotterSearch >> initialize [
	super initialize.

	itemsLimit := 5.
	
	objectTransformation := [ :anObject :aStep | anObject ].
	objectToolTransformation := [ :anObject :aStep | anObject gtDefaultInspectorTool ].
	hasObjectAction := true.
	
	actOnLogicComputation := [ :anObject :aSpotterStep :anElement |
		anObject gtSpotterActDefault: aSpotterStep from: anElement ].
	actOnCategoryLogicComputation := [ :aCategory :aSpotterStep :anElement |
		aCategory gtSpotterActDefault: aSpotterStep from: anElement ]
]

{ #category : #'api - configuration' }
GtSpotterSearch >> itemActLogic: aBlockWithTwoArguments [
	self deprecated: 'Use send: or sendTool:, otherwise handle GtSpotterObjectActOn notification to customize the act-on behavior'.

	actOnLogicComputation := aBlockWithTwoArguments
]

{ #category : #'private - computation' }
GtSpotterSearch >> itemActOn: anObject for: aSpotterStep from: anElement [
	self hasObjectAction
		ifFalse: [ ^ self ].

	actOnLogicComputation
		ifNotNil: [ :aBlock | aBlock cull: anObject cull: aSpotterStep cull: anElement ]
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
GtSpotterSearch >> objectToActOn: anObject from: aSpotterStep [
	"Return an object that should be acted upon from a given step."
	<return: #Object>
	
	^ objectTransformation cull: anObject cull: aSpotterStep
]

{ #category : #'private - computation' }
GtSpotterSearch >> objectToolToActOn: anObject from: aSpotterStep [
	"Return a tool that should be acted upon from a given step"
	<return: #GtPhlowTool>

	^ objectToolTransformation cull: anObject cull: aSpotterStep
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
GtSpotterSearch >> sendTool: aBlock [
	objectToolTransformation := aBlock
]

{ #category : #'api - configuration' }
GtSpotterSearch >> withoutCategoryAction [
	actOnCategoryLogicComputation := nil
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
