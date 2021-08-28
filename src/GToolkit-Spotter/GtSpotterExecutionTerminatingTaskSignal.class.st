Class {
	#name : 'GtSpotterExecutionTerminatingTaskSignal',
	#superclass : 'GtSpotterTaskSignal',
	#instVars : [
		'terminatingCommand'
	],
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : 'accessing' }
GtSpotterExecutionTerminatingTaskSignal >> name [
	^ 'Spotter Terminating: ', self terminatingCommand query, ' from ', self query
]

{ #category : 'instance creation' }
GtSpotterExecutionTerminatingTaskSignal >> newCommand [
	^ self command
]

{ #category : 'instance creation' }
GtSpotterExecutionTerminatingTaskSignal >> newCommand: aNewCommand [
	self command: aNewCommand
]

{ #category : 'accessing' }
GtSpotterExecutionTerminatingTaskSignal >> signalName [
	^ 'Terminating'
]

{ #category : 'accessing' }
GtSpotterExecutionTerminatingTaskSignal >> terminatingCommand [
	^ terminatingCommand
]

{ #category : 'accessing' }
GtSpotterExecutionTerminatingTaskSignal >> terminatingCommand: anObject [
	terminatingCommand := anObject
]
