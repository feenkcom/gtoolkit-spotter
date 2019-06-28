Class {
	#name : #GtSpotterCandidatesProcessor,
	#superclass : #GtSpotterProcessor,
	#instVars : [
		'origin',
		'allCandidates'
	],
	#category : #'GToolkit-Spotter-Model - Processors'
}

{ #category : #'instance creation' }
GtSpotterCandidatesProcessor class >> on: anObject [

	^ self new origin: anObject
]

{ #category : #compatibility }
GtSpotterCandidatesProcessor >> allCandidatesIn: aContext [
	^ self allItemsIn: aContext
]

{ #category : #public }
GtSpotterCandidatesProcessor >> allItemsIn: aContext [

	^ allCandidates ifNil: [ allCandidates := (self computeAllItemsIn: aContext) copy ].
]

{ #category : #compatibility }
GtSpotterCandidatesProcessor >> candidatesLimit [
	^ self itemsLimit
]

{ #category : #private }
GtSpotterCandidatesProcessor >> computeAllItemsIn: aContext [

	^ OrderedCollection new
	
]

{ #category : #compatibility }
GtSpotterCandidatesProcessor >> computeCandidatesIn: aContext [

	^ self computeAllItemsIn: aContext
]

{ #category : #private }
GtSpotterCandidatesProcessor >> continueItemsLimit [
	^ (self defaultContinueItemsLimit - self itemsLimit) max: 0
]

{ #category : #private }
GtSpotterCandidatesProcessor >> doFilterInContext: aSpotterContext [
	^ aSpotterContext doFilter: GTFilterBlock gtFilter forProcessor: self
]

{ #category : #private }
GtSpotterCandidatesProcessor >> itemFilterNameFor: anObject [
	^ self itemNameFor: anObject
]

{ #category : #private }
GtSpotterCandidatesProcessor >> itemIconFor: anObject [
	^ nil
]

{ #category : #private }
GtSpotterCandidatesProcessor >> itemNameFor: anObject [
	^ anObject gtDisplayString
]

{ #category : #accessing }
GtSpotterCandidatesProcessor >> itemsLimit [
	"Return the maximal number of elements that can be found during search.
	Default implementation returns infinity, so the number of element is not limited."
	^ Float infinity
]

{ #category : #accessing }
GtSpotterCandidatesProcessor >> origin [

	^ origin
]

{ #category : #accessing }
GtSpotterCandidatesProcessor >> origin: anObject [

	origin := anObject
]

{ #category : #private }
GtSpotterCandidatesProcessor >> prepareProcessorInContext: aContext [
	super prepareProcessorInContext: aContext.
	
	self hasDynamicItems ifTrue: [ allCandidates := nil ]
]

{ #category : #private }
GtSpotterCandidatesProcessor >> render: anObject [
	^ GtSpotterItemBrick new
		icon: (self itemIconFor: anObject);
		text: (self itemNameFor: anObject)
]

{ #category : #accessing }
GtSpotterCandidatesProcessor >> title [
	^ 'undefined'
]
