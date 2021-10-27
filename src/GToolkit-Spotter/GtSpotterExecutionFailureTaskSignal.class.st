Class {
	#name : #GtSpotterExecutionFailureTaskSignal,
	#superclass : #GtSpotterTaskSignal,
	#instVars : [
		'exception'
	],
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : #accessing }
GtSpotterExecutionFailureTaskSignal >> exception: anException [
	exception := anException
]

{ #category : #accessing }
GtSpotterExecutionFailureTaskSignal >> signalName [
	^ 'Failure'
]
