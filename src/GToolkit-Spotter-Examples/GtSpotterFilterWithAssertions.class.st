Class {
	#name : #GtSpotterFilterWithAssertions,
	#superclass : #GtFilter,
	#category : #'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : #public }
GtSpotterFilterWithAssertions >> value: aSpotterContext [
	" No Exceptions expected ! "
	| currentExceptionHandler |
	currentExceptionHandler := GtCurrentSpotterExceptionHandler value.
	self assert: currentExceptionHandler notNil.
	self assert: currentExceptionHandler == aSpotterContext exceptionHandler.
	self assert: currentExceptionHandler == aSpotterContext step exceptionHandler.
	self assert: currentExceptionHandler == aSpotterContext spotter exceptionHandler.
	^ #( 'done' )
]
