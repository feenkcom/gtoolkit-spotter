"
I am a asynchronous task adaptor.
I use a Bloc TaskIt worker pool to schedule background tasks.


"
Class {
	#name : 'GtSpotterTaskItAsyncTask',
	#superclass : 'GtSpotterTask',
	#instVars : [
		'command',
		'mutex',
		'spotterCommand'
	],
	#category : 'GToolkit-Spotter-Utils'
}

{ #category : 'api - execution' }
GtSpotterTaskItAsyncTask >> execute: aGtSpotterTaskCommand [
	BlUseAsyncFeatures 
		ifEnabledDo: [
			mutex critical: [ 
				self terminateBecauseOf: aGtSpotterTaskCommand.
				self postpone: aGtSpotterTaskCommand ] ]
		otherwise: [ 
			GtSpotterSyncTask new execute: aGtSpotterTaskCommand ]
]

{ #category : 'initialization' }
GtSpotterTaskItAsyncTask >> initialize [
	super initialize.
	mutex := Mutex new.
]

{ #category : 'instance creation' }
GtSpotterTaskItAsyncTask >> newSearchCommandFor: aGtSpotterTaskCommand [
	| aCommand |
	spotterCommand := aGtSpotterTaskCommand.
	aCommand := [ 
			| aResult |
			self signalExecutionStart: aGtSpotterTaskCommand.
			aResult := aGtSpotterTaskCommand execute.
			self signalExecutionFinished: aGtSpotterTaskCommand withResult: aResult ] 
		asBlTktTerminableCommand asBlTktLoggingCommand.
	aCommand name: 'Spotter Search for ''', aGtSpotterTaskCommand query asString, ''''.
	^ aCommand
]

{ #category : 'execution' }
GtSpotterTaskItAsyncTask >> postpone: aGtSpotterTaskCommand [
	"Must be called withing monitor critical code"
	| aCommand |
	command := aCommand := BlTaskAtPostponedTerminableFuture new.
	aCommand
		command: (self newSearchCommandFor: aGtSpotterTaskCommand);
		onSuccessDo:  [ :aResult | 
			aCommand == command ifTrue: [ aGtSpotterTaskCommand notifySuccess: aResult ] ];
		onFailureDo: [ :anException | 
			self signalFailure: anException for: aGtSpotterTaskCommand ];
		pool: BlTktWorkerProvider spotterPool;
		scheduledTime: BlTime real now + aGtSpotterTaskCommand delay.
	BlTaskAtQueue default schedule: command
]

{ #category : 'signaling' }
GtSpotterTaskItAsyncTask >> signalTerminationOf: aCurrentCommand becauseOf: aNewCommand [
	GtSpotterExecutionTerminatingTaskSignal new
		task: self;
		terminatingCommand: aCurrentCommand;
		newCommand: aNewCommand;
		emit
]

{ #category : 'execution' }
GtSpotterTaskItAsyncTask >> terminate [
	"Must be called withing monitor critical code"
	command ifNotNil: [ :aCommand | aCommand terminate ]
]

{ #category : 'execution' }
GtSpotterTaskItAsyncTask >> terminateBecauseOf: aNewCommand [
	"Must be called withing monitor critical code"
	command ifNotNil: [ :aCurrentCommand | 
		self signalTerminationOf: spotterCommand becauseOf: aNewCommand.
		aCurrentCommand terminate ]
]
