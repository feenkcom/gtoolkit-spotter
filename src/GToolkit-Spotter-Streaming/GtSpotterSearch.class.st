Class {
	#name : #GtSpotterSearch,
	#superclass : #GtSpotterProtoSearch,
	#instVars : [
		'itemNameComputation',
		'objectToActOnComputation',
		'actOnLogicComputation',
		'previewElementComputation',
		'itemsLimit',
		'actOnCategoryLogicComputation'
	],
	#category : #'GToolkit-Spotter-Streaming-Searches'
}

{ #category : #converting }
GtSpotterSearch >> asStreamFor: aSpotterContext [
	<return: #TAsyncStream>
	
	^ self subclassResponsibility
]

{ #category : #'api - configuration' }
GtSpotterSearch >> categoryActLogic: aBlockWithTwoArguments [
	actOnLogicComputation := aBlockWithTwoArguments
]

{ #category : #'private - computation' }
GtSpotterSearch >> categoryActOn: aCategory for: aSpotterStep from: anElement [
	actOnCategoryLogicComputation
		ifNotNil: [ :aBlock | aBlock cull: aCategory cull: aSpotterStep cull: anElement ]
]

{ #category : #accessing }
GtSpotterSearch >> hasCategoryActOn [
	^ actOnCategoryLogicComputation isNotNil
]

{ #category : #accessing }
GtSpotterSearch >> hasItemActOn [
	^ actOnLogicComputation isNotNil
]

{ #category : #initialization }
GtSpotterSearch >> initialize [
	super initialize.

	itemsLimit := 5.
	actOnLogicComputation := [ :anObject :aSpotterStep :anElement | anObject gtSpotterActDefault: aSpotterStep from: anElement ].
	actOnCategoryLogicComputation := [ :aCategory :aSpotterStep :anElement | aCategory gtSpotterActDefault: aSpotterStep from: anElement ]
]

{ #category : #'api - configuration' }
GtSpotterSearch >> itemActLogic: aBlockWithTwoArguments [
	actOnLogicComputation := aBlockWithTwoArguments
]

{ #category : #'private - computation' }
GtSpotterSearch >> itemActOn: anObject for: aSpotterStep from: anElement [
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
	"Return an object that should be acted upon from a given step"
	<return: #Object>
	
	^ objectToActOnComputation
		ifNil: [ anObject ]
		ifNotNil: [ objectToActOnComputation cull: anObject cull: aSpotterStep ]
]

{ #category : #'api - configuration' }
GtSpotterSearch >> previewElement: aBlockWithOneArgument [
	previewElementComputation := aBlockWithOneArgument
]

{ #category : #'private - computation' }
GtSpotterSearch >> previewElementFor: anObject [
	<return: #BlElement or: nil>
	
	^ previewElementComputation
		ifNil: [ self privateDefaultPreviewElementFor: anObject ]
		ifNotNil: [ :aBlock | aBlock cull: anObject ]
]

{ #category : #'private - computation' }
GtSpotterSearch >> previewObjectFor: anObject [
	^ anObject
]

{ #category : #'private - computation' }
GtSpotterSearch >> privateDefaultPreviewElementFor: anObject [
	<return: #BlElement or: nil>
	| aPreviewElement |
	
	aPreviewElement := nil.

	(anObject gtViewsFor: GtPhlowView empty) originalView
		asElementDo: [ :anElement | aPreviewElement := anElement ].

	^ aPreviewElement
]

{ #category : #'api - configuration' }
GtSpotterSearch >> withoutCategoryAction [
	actOnCategoryLogicComputation := nil
]

{ #category : #'api - configuration' }
GtSpotterSearch >> withoutItemAction [
	actOnLogicComputation := nil
]

{ #category : #'api - configuration' }
GtSpotterSearch >> withoutItemsLimit [
	self itemsLimit: Float infinity
]
