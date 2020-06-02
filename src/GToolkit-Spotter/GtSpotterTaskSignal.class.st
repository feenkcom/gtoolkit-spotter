Class {
	#name : #GtSpotterTaskSignal,
	#superclass : #GtSpotterSignal,
	#instVars : [
		'task',
		'command'
	],
	#category : #'GToolkit-Spotter-Logging'
}

{ #category : #accessing }
GtSpotterTaskSignal >> command [
	^ command
]

{ #category : #accessing }
GtSpotterTaskSignal >> command: anObject [
	command := anObject
]

{ #category : #accessing }
GtSpotterTaskSignal >> context [
	^ self command context
]

{ #category : #accessing }
GtSpotterTaskSignal >> name [
	^ 'Spotter ', self signalName, ': ', self query asString
]

{ #category : #printing }
GtSpotterTaskSignal >> printOn: aStream [ 
	self command ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPutAll: self name;
		nextPutAll: ': ';
		print: self query
]

{ #category : #accessing }
GtSpotterTaskSignal >> query [
	^ self command query
]

{ #category : #accessing }
GtSpotterTaskSignal >> signalName [
	^ self className
]

{ #category : #accessing }
GtSpotterTaskSignal >> task [
	^ task
]

{ #category : #accessing }
GtSpotterTaskSignal >> task: anObject [
	task := anObject
]
