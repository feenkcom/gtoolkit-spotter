Class {
	#name : #GtSpotterAsyncTask,
	#superclass : #Object,
	#instVars : [
		'command'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #async }
GtSpotterAsyncTask >> execute: aBlock withArguments: aCollection callback: aCallbackBlock priority: aPriority delay: anIntegerMilliseconds [
	| aPool aCommand aFuture |
	self terminate.
	aPool := BlTktWorkerProvider highUICPUBoundPool.
	aCommand := command := [
		anIntegerMilliseconds > 0 ifTrue: [ anIntegerMilliseconds milliSeconds wait ].
		aBlock valueWithEnoughArguments: aCollection ] asBlTktCommand.
	aCommand name: 'Spotter Task'.
	aFuture := aPool future: aCommand.
	aCallbackBlock ifNotNil: [ 
		aFuture
			onSuccessDo: [ :aResult | 
				"we use it to pass result from background thread and execute callback block in UI thread"
				UIManager default
					defer: [ aCommand == command ifTrue: [ aCallbackBlock cull: aResult ] ] ] ]
]

{ #category : #async }
GtSpotterAsyncTask >> terminate [
	command
		ifNotNil: [ :aCommand | aCommand terminationRequested ]
]
