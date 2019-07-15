Class {
	#name : #GtSpotterDebuggingExceptionHandler,
	#superclass : #GtSpotterExceptionHandler,
	#category : #'GToolkit-Spotter-Exceptions'
}

{ #category : #public }
GtSpotterDebuggingExceptionHandler >> handleException: anException do: aBlock [
	anException pass.
	^ super handleException: anException do: aBlock.
	
	
]
