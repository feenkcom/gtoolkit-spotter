Class {
	#name : 'GtSpotterSyncTask',
	#superclass : 'GtSpotterTask',
	#category : 'GToolkit-Spotter-Utils'
}

{ #category : 'api - execution' }
GtSpotterSyncTask >> execute: aGtSpotterTaskCommand [
	self signalExecutionStart: aGtSpotterTaskCommand.
	[ 
		| aResult |
		aResult := aGtSpotterTaskCommand execute.
		aGtSpotterTaskCommand notifySuccess: aResult.
		self signalExecutionFinished: aGtSpotterTaskCommand withResult: aResult.
	] on: Error do: [ :anException | 
		self signalFailure: anException for: aGtSpotterTaskCommand.
		aGtSpotterTaskCommand notifyFailure: anException.
		anException pass ].
]

{ #category : 'api - execution' }
GtSpotterSyncTask >> terminate [
	"do nothing"
]
