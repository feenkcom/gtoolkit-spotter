"
A small delay before actual searching makes spotter faster :)


"
Class {
	#name : #GtSpotterTaskCommand,
	#superclass : #Object,
	#traits : 'TBlDebug',
	#classTraits : 'TBlDebug classTrait',
	#instVars : [
		'query',
		'delay',
		'valuable',
		'context',
		'arguments',
		'onSuccess',
		'onFailure'
	],
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #'api - convenience' }
GtSpotterTaskCommand >> argument: anObject [
	self arguments: { anObject }
]

{ #category : #'api - accessing' }
GtSpotterTaskCommand >> arguments [
	^ arguments
]

{ #category : #'api - accessing' }
GtSpotterTaskCommand >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
GtSpotterTaskCommand >> context [
	^ context
]

{ #category : #accessing }
GtSpotterTaskCommand >> context: anObject [
	context := anObject
]

{ #category : #defaults }
GtSpotterTaskCommand >> defaltQuery [
	^ ''
]

{ #category : #defaults }
GtSpotterTaskCommand >> defaultArguments [
	^ Array empty
]

{ #category : #defaults }
GtSpotterTaskCommand >> defaultDelay [
	^ 200 milliSeconds
]

{ #category : #defaults }
GtSpotterTaskCommand >> defaultOnFailure [
	^ Array empty
]

{ #category : #defaults }
GtSpotterTaskCommand >> defaultOnSuccess [
	^ Array empty
]

{ #category : #defaults }
GtSpotterTaskCommand >> defaultValuable [
	^ [ "do nothing" ]
]

{ #category : #'api - accessing' }
GtSpotterTaskCommand >> delay [
	^ delay
]

{ #category : #'api - accessing' }
GtSpotterTaskCommand >> delay: anObject [
	delay := anObject
]

{ #category : #'api - execution' }
GtSpotterTaskCommand >> execute [
	^ self valuable valueWithPossibleArgs: self arguments
]

{ #category : #initialization }
GtSpotterTaskCommand >> initialize [
	super initialize.
	arguments := self defaultArguments.
	delay := self defaultDelay. 
	onFailure := self defaultOnFailure.
	onSuccess := self defaultOnSuccess.
	query := self defaltQuery.
	valuable := self defaultValuable.
]

{ #category : #'api - notification' }
GtSpotterTaskCommand >> notifyFailure: anException [
	self onFailure do: [ :eachValuable | eachValuable cull: anException ]
]

{ #category : #'api - notification' }
GtSpotterTaskCommand >> notifySuccess: aResult [
	self onSuccess do: [ :eachValuable | eachValuable cull: aResult ]
]

{ #category : #'api - accessing' }
GtSpotterTaskCommand >> onFailure [
	^ onFailure
]

{ #category : #'api - accessing' }
GtSpotterTaskCommand >> onFailure: anObject [
	onFailure := anObject
]

{ #category : #'api - accessing' }
GtSpotterTaskCommand >> onFailureDo: aValuable [
	onFailure := onFailure copyWith: aValuable
]

{ #category : #'api - accessing' }
GtSpotterTaskCommand >> onSuccess [
	^ onSuccess
]

{ #category : #'api - accessing' }
GtSpotterTaskCommand >> onSuccessDo: aValuable [
	onSuccess := onSuccess copyWith: aValuable
]

{ #category : #printing }
GtSpotterTaskCommand >> printOn: aStream [
	self query ifNil: [ ^ super printOn: aStream ].
	aStream 
		nextPutAll: 'Query: ';
		print: self query
]

{ #category : #'api - accessing' }
GtSpotterTaskCommand >> query [
	^ query
]

{ #category : #'api - accessing' }
GtSpotterTaskCommand >> query: anObject [
	query := anObject
]

{ #category : #'api - accessing' }
GtSpotterTaskCommand >> valuable [
	^ valuable
]

{ #category : #'api - accessing' }
GtSpotterTaskCommand >> valuable: anObject [
	valuable := anObject
]
