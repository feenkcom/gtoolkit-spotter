Class {
	#name : #GtSpotterExceptionHandler,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Exceptions'
}

{ #category : #public }
GtSpotterExceptionHandler >> handleException: anException [
	^ self handleException: anException do: [ 
		('[Spotter] Exception: ', anException asString) logCr ]
]

{ #category : #public }
GtSpotterExceptionHandler >> handleException: anException do: aBlock [
	^ aBlock value
]

{ #category : #public }
GtSpotterExceptionHandler >> handleException: anException with: anObject [
	^ self handleException: anException do: [ anObject ]
]

{ #category : #handling }
GtSpotterExceptionHandler >> handleExceptionsDuring: aBlock [
	[ GTCurrentSpotterExceptionHandler use: self during: aBlock ] 
		on: self 
		do: [ :exception | 
			[ self handleException: exception ] " handle any exception during aBlock "
				on: Error
				do: [ :fatalException | self handleFatalException: fatalException ] ] " handle exception caused while handling an exception "
]

{ #category : #private }
GtSpotterExceptionHandler >> handleFatalException: anException [
	('[Spotter] Fatal Exception: ', anException asString) logCr
]
