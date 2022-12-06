Class {
	#name : #GtSpotterFilterWithAssertions,
	#superclass : #Object,
	#traits : 'TGtSpotterFilter',
	#classTraits : 'TGtSpotterFilter classTrait',
	#category : #'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : #evaluating }
GtSpotterFilterWithAssertions >> applyInScope: aStream context: aSpotterContext [
	" No Exceptions expected ! "
	| currentExceptionHandler |
	currentExceptionHandler := GtCurrentSpotterExceptionHandler value.
	self assert: currentExceptionHandler notNil.
	self assert: currentExceptionHandler == aSpotterContext exceptionHandler.
	self assert: currentExceptionHandler == aSpotterContext step exceptionHandler.
	self assert: currentExceptionHandler == aSpotterContext spotter exceptionHandler.
	^ #( 'done' )
]
