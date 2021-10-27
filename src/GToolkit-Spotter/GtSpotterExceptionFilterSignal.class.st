Class {
	#name : #GtSpotterExceptionFilterSignal,
	#superclass : #GtSpotterFilterSignal,
	#instVars : [
		'exception'
	],
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : #accessing }
GtSpotterExceptionFilterSignal >> exception [
	^ exception
]

{ #category : #accessing }
GtSpotterExceptionFilterSignal >> exception: anException [ 
	exception := anException
]

{ #category : #accessing }
GtSpotterExceptionFilterSignal >> name [
	^ 'Spotter Filter Exception: ', self exception asString
]
