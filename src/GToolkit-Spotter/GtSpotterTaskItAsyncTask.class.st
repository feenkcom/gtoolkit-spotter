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
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #async }
GtSpotterTaskItAsyncTask >> execute: aBlock withArguments: aCollection callback: aCallbackBlock priority: aPriority delay: anIntegerMilliseconds [
	| aPool aCommand aFuture |
	self terminate.
	BlUseAsyncFeatures 
		ifEnabledDo: [ 
			aPool := BlTktWorkerProvider spotterPool.
			aCommand := command := [
				"anIntegerMilliseconds > 0 ifTrue: [ anIntegerMilliseconds milliSeconds wait ]."
				aBlock valueWithEnoughArguments: aCollection ] asBlTktTerminableCommand asBlTktLoggingCommand.
			"TODO: aPriority is not a priority, but a query string. 
			We should change the method name it once we are fine with the implementation."
			aCommand name: 'Spotter Search for ''', aPriority asString, ''''.
			aFuture := aPool future: aCommand.
			aCallbackBlock ifNotNil: [ 
				aFuture
					onSuccessDo: [ :aResult | 
						aCommand == command ifTrue: [ aCallbackBlock cull: aResult ] ] ] ]
		otherwise: [ 
			| aResult |
			aResult := aBlock valueWithEnoughArguments: aCollection.
			aCallbackBlock cull: aResult ]
]

{ #category : #async }
GtSpotterTaskItAsyncTask >> terminate [
	command
		ifNotNil: [ :aCommand | aCommand terminate ]
]
