Class {
	#name : #GtSpotterBlockIterator,
	#superclass : #GtSpotterIterator,
	#instVars : [
		'onDo'
	],
	#category : 'GToolkit-Spotter-Iterators'
}

{ #category : #private }
GtSpotterBlockIterator >> itemDo: aBlock [ 
	self onDo 
		cull: aBlock
		cull: self context 
]

{ #category : #accessing }
GtSpotterBlockIterator >> onDo [
	^ onDo ifNil: [ onDo := [ :anItemBlock :aContext | " do nothing " ] ]
]

{ #category : #accessing }
GtSpotterBlockIterator >> onDo: anObject [
	onDo := anObject
]
