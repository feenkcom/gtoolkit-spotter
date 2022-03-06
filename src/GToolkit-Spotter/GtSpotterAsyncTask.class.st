"
I am a asynchronous task adaptor.
I use a Bloc TaskIt worker pool to schedule background tasks.


"
Class {
	#name : #GtSpotterAsyncTask,
	#superclass : #GtSpotterTask,
	#instVars : [
		'mutex',
		'spotterCommand',
		'promise'
	],
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #'api - execution' }
GtSpotterAsyncTask >> execute: aGtSpotterTaskCommand [
	BlUseAsyncFeatures 
		ifEnabledDo: [
			mutex critical: [ 
				self terminateBecauseOf: aGtSpotterTaskCommand.
				self postpone: aGtSpotterTaskCommand ] ]
		otherwise: [ 
			GtSpotterSyncTask new execute: aGtSpotterTaskCommand ]
]

{ #category : #initialization }
GtSpotterAsyncTask >> initialize [
	super initialize.
	mutex := Mutex new.
]

{ #category : #private }
GtSpotterAsyncTask >> newSearchFutureFor: aGtSpotterTaskCommand [
	<return: #TAsyncFuture>
	spotterCommand := aGtSpotterTaskCommand.
	^ [ 
			| aResult |
			self signalExecutionStart: aGtSpotterTaskCommand.
			aResult := aGtSpotterTaskCommand execute.
			self signalExecutionFinished: aGtSpotterTaskCommand withResult: aResult.
			aResult ] asAsyncFuture
]

{ #category : #private }
GtSpotterAsyncTask >> postpone: aGtSpotterTaskCommand [
	"Must be called withing monitor critical code"
	| aPromise |
	
	promise := aPromise := ((self newSearchFutureFor: aGtSpotterTaskCommand) delayed: aGtSpotterTaskCommand delay)
		await: (AsyncFutureExecutionConfiguration new customGroup: #Spotter).
	
	promise
		then: [ :aResult | aPromise == promise ifTrue: [ aGtSpotterTaskCommand notifySuccess: aResult ] ]
		otherwise: [ :anException | self signalFailure: anException for: aGtSpotterTaskCommand ].
		
	^ aPromise
]

{ #category : #private }
GtSpotterAsyncTask >> signalTerminationOf: aCurrentPromise becauseOf: aNewFuture [
	GtSpotterExecutionTerminatingTaskSignal new
		task: self;
		terminatingCommand: aCurrentPromise;
		newCommand: aNewFuture;
		emit
]

{ #category : #private }
GtSpotterAsyncTask >> terminate [
	"Must be called withing monitor critical code"
	promise ifNotNil: [ :aPromise | aPromise cancelSoft ]
]

{ #category : #private }
GtSpotterAsyncTask >> terminateBecauseOf: aNewFuture [
	"Must be called withing monitor critical code"
	promise ifNotNil: [ :aCurrentPromise | 
		self signalTerminationOf: spotterCommand becauseOf: aNewFuture.
		aCurrentPromise cancelSoft ]
]
