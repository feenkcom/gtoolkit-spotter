"
I am a asynchronous task adaptor.
I use a Bloc TaskIt worker pool to schedule background tasks.
"
Class {
	#name : #GtSpotterTaskItAsyncTask,
	#superclass : #Object,
	#instVars : [
		'command',
		'mutex'
	],
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #async }
GtSpotterTaskItAsyncTask >> execute: aBlock withArguments: aCollection callback: aCallbackBlock priority: aPriority delay: anIntegerMilliseconds [
	"TODO: aPriority is not a priority, but a query string. 
	We should change the method name it once we are fine with the implementation."
	BlUseAsyncFeatures 
		ifEnabledDo: [
			mutex critical: [ 
				self terminate.
				self 
					postponeSearchingOf: aPriority asString 
					for: aBlock 
					withArguments: aCollection 
					callback: aCallbackBlock 
					delay: anIntegerMilliseconds milliSeconds ] ]
		otherwise: [ 
			| aResult |
			aResult := aBlock valueWithEnoughArguments: aCollection.
			aCallbackBlock cull: aResult ]
]

{ #category : #initialization }
GtSpotterTaskItAsyncTask >> initialize [
	super initialize.
	mutex := Mutex new.
]

{ #category : #'instance creation' }
GtSpotterTaskItAsyncTask >> newSearchCommandOf: aName for: aBlock withArguments: aCollection [
	| aCommand |
	aCommand := [ aBlock valueWithEnoughArguments: aCollection ] 
		asBlTktTerminableCommand asBlTktLoggingCommand.
	aCommand name: 'Spotter Search for ''', aName asString, ''''.
	^ aCommand
]

{ #category : #async }
GtSpotterTaskItAsyncTask >> postponeSearchingOf: aName for: aBlock withArguments: aCollection callback: aCallbackBlock delay: aDelay [
	"Must be called withing monitor critical code"
	| aCommand |
	command := aCommand := BlTaskAtPostponedTerminableFuture new.
	aCommand
		command: (self newSearchCommandOf: aName for: aBlock withArguments: aCollection);
		onSuccessDo:  [ :aResult | 
				aCommand == command ifTrue: [ aCallbackBlock cull: aResult ] ];
		pool: BlTktWorkerProvider spotterPool;
		scheduledTime: BlTime real now + aDelay.
	BlTaskAtQueue default schedule: command
]

{ #category : #async }
GtSpotterTaskItAsyncTask >> terminate [
	"Must be called withing monitor critical code"
	command ifNotNil: [ :aCommand | aCommand terminate ]
]
