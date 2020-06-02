Class {
	#name : #GtSpotterExecutionFinishedTaskSignal,
	#superclass : #GtSpotterTaskSignal,
	#instVars : [
		'result'
	],
	#category : #'GToolkit-Spotter-Logging'
}

{ #category : #accessing }
GtSpotterExecutionFinishedTaskSignal >> result [
	^ result
]

{ #category : #accessing }
GtSpotterExecutionFinishedTaskSignal >> result: anObject [
	result := anObject
]

{ #category : #accessing }
GtSpotterExecutionFinishedTaskSignal >> signalName [
	^ 'Finished'
]
