"
I am a asynchronous task adaptor.
I use a Bloc TaskIt worker pool to schedule background tasks.
"
Class {
	#name : #GtSpotterTaskItAsyncTask,
	#superclass : #Object,
	#instVars : [
		'command'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #async }
GtSpotterTaskItAsyncTask >> execute: aBlock withArguments: aCollection callback: aCallbackBlock priority: aPriority delay: anIntegerMilliseconds [
	| aPool aCommand aFuture |
	self terminate.
	aPool := BlTktWorkerProvider highUICPUBoundPool.
	aCommand := command := [ :aTaskItContext |
		anIntegerMilliseconds > 0 ifTrue: [ anIntegerMilliseconds milliSeconds wait ].
		aTaskItContext isTerminationRequested ifFalse: [ 
			aBlock valueWithEnoughArguments: aCollection ] ] asBlTktCommand.
	aCommand name: 'Spotter Task'.
	aFuture := aPool future: aCommand.
	aCallbackBlock ifNotNil: [ 
		aFuture
			onSuccessDo: [ :aResult | 
				aCommand == command ifTrue: [ aCallbackBlock cull: aResult ] ] ]
]

{ #category : #async }
GtSpotterTaskItAsyncTask >> terminate [
	command
		ifNotNil: [ :aCommand | aCommand terminationRequested ]
]
