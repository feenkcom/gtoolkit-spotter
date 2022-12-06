Class {
	#name : #GtSpotterFilterWithException,
	#superclass : #Object,
	#traits : 'TGtSpotterFilter',
	#classTraits : 'TGtSpotterFilter classTrait',
	#category : #'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : #evaluating }
GtSpotterFilterWithException >> applyInScope: aStream context: aSpotterContext [
	ArithmeticError signal: 'Error while filtering' " Exception while filtering "
]
