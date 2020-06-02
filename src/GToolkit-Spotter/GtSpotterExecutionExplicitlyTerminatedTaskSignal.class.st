Class {
	#name : #GtSpotterExecutionExplicitlyTerminatedTaskSignal,
	#superclass : #GtSpotterTaskSignal,
	#instVars : [
		'exception'
	],
	#category : #'GToolkit-Spotter-Logging'
}

{ #category : #accessing }
GtSpotterExecutionExplicitlyTerminatedTaskSignal >> exception [
	^ exception
]

{ #category : #accessing }
GtSpotterExecutionExplicitlyTerminatedTaskSignal >> exception: anObject [
	exception := anObject
]

{ #category : #accessing }
GtSpotterExecutionExplicitlyTerminatedTaskSignal >> signalName [
	^ 'Terminated'
]
