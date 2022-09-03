Class {
	#name : #GtSpotterSearch,
	#superclass : #GtSpotterProtoSearch,
	#instVars : [
		'title',
		'priority',
		'definingMethod',
		'itemNameComputation',
		'objectToActOnComputation',
		'actOnLogicComputation'
	],
	#category : #'GToolkit-Spotter-Streaming-Searches'
}

{ #category : #'api - configuration' }
GtSpotterSearch >> actLogic: aBlockWithTwoArguments [
	actOnLogicComputation := aBlockWithTwoArguments
]

{ #category : #'private - computation' }
GtSpotterSearch >> actOn: anObject for: aSpotterStep from: anElement [
	actOnLogicComputation
		ifNil: [ anObject gtSpotterActDefault: aSpotterStep from: anElement ]
		ifNotNil: [ actOnLogicComputation cull: anObject cull: aSpotterStep cull: anElement ]
]

{ #category : #converting }
GtSpotterSearch >> asStreamFor: aSpotterContext [
	<return: #TAsyncStream>
	
	^ self subclassResponsibility
]

{ #category : #initialization }
GtSpotterSearch >> definingMethod: aCompiledMethod [
	definingMethod := aCompiledMethod
]

{ #category : #initialization }
GtSpotterSearch >> initialize [
	super initialize.
	
	title := 'Untitled'.
	priority := 10
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

{ #category : #'private - computation' }
GtSpotterSearch >> objectToActOn: anObject from: aSpotterStep [
	"Return an object that should be acted upon from a given step"
	<return: #Object>
	
	^ objectToActOnComputation
		ifNil: [ anObject ]
		ifNotNil: [ objectToActOnComputation cull: anObject cull: aSpotterStep ]
]

{ #category : #accessing }
GtSpotterSearch >> priority [

	^ priority
]

{ #category : #'api - configuration' }
GtSpotterSearch >> priority: aNumber [
	priority := aNumber
]

{ #category : #accessing }
GtSpotterSearch >> title [

	^ title
]

{ #category : #'api - configuration' }
GtSpotterSearch >> title: aString [
	title := aString
]
