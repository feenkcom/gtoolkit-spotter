Class {
	#name : #GtSpotterDebuggingExceptionHandler,
	#superclass : #GTSpotterExceptionHandler,
	#category : #'GToolkit-Spotter-Exceptions'
}

{ #category : #public }
GtSpotterDebuggingExceptionHandler >> handleException: anException do: aBlock [
	anException pass.
	^ super handleException: anException do: aBlock.
	
	
]
