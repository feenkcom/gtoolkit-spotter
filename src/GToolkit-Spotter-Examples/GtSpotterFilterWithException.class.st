Class {
	#name : 'GtSpotterFilterWithException',
	#superclass : 'GtFilter',
	#category : 'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : 'public' }
GtSpotterFilterWithException >> value: aSpotterContext [
	ArithmeticError signal: 'Error while filtering' " Exception while filtering "
]
