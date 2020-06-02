Class {
	#name : #GtSpotterTask,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #'api - execution' }
GtSpotterTask >> execute: aGtSpotterTaskCommand [
	self subclassResponsibility
]

{ #category : #signaling }
GtSpotterTask >> signalExecutionFinished: aGtSpotterTaskCommand withResult: aResult [
	GtSpotterExecutionFinishedTaskSignal new
		task: self;
		command: aGtSpotterTaskCommand;
		result: aResult;
		emit
]

{ #category : #signaling }
GtSpotterTask >> signalExecutionStart: aGtSpotterTaskCommand [
	GtSpotterExecutionStartTaskSignal new
		task: self;
		command: aGtSpotterTaskCommand;
		emit
]

{ #category : #signaling }
GtSpotterTask >> signalFailure: anException for: aGtSpotterTaskCommand [
	GtSpotterExecutionFailureTaskSignal new
		task: self;
		command: aGtSpotterTaskCommand;
		exception: anException;
		emit
]
