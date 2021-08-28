Class {
	#name : 'GtCurrentSpotterExceptionHandler',
	#superclass : 'Notification',
	#category : 'GToolkit-Spotter-Exceptions'
}

{ #category : 'accessing' }
GtCurrentSpotterExceptionHandler class >> defaultValue [
	^ nil
]

{ #category : 'evaluating' }
GtCurrentSpotterExceptionHandler class >> use: anObject during: aBlock [
	
	^ aBlock on: self do: [ :notification | notification resume: anObject ]
]

{ #category : 'evaluating' }
GtCurrentSpotterExceptionHandler class >> value [
	^ self signal
]

{ #category : 'exceptiondescription' }
GtCurrentSpotterExceptionHandler >> defaultAction [
	^ self class defaultValue
]
