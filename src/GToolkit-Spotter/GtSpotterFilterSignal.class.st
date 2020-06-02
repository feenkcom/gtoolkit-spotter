Class {
	#name : #GtSpotterFilterSignal,
	#superclass : #GtSpotterSignal,
	#instVars : [
		'context',
		'processor',
		'filter',
		'streamed'
	],
	#category : #'GToolkit-Spotter-Logging'
}

{ #category : #accessing }
GtSpotterFilterSignal >> context [
	^ context
]

{ #category : #accessing }
GtSpotterFilterSignal >> context: anObject [
	context := anObject
]

{ #category : #accessing }
GtSpotterFilterSignal >> filter [
	^ filter
]

{ #category : #accessing }
GtSpotterFilterSignal >> filter: anObject [
	filter := anObject
]

{ #category : #testing }
GtSpotterFilterSignal >> isFilterSignal [
	^ true
]

{ #category : #accessing }
GtSpotterFilterSignal >> processor [
	^ processor
]

{ #category : #accessing }
GtSpotterFilterSignal >> processor: anObject [
	processor := anObject
]

{ #category : #accessing }
GtSpotterFilterSignal >> query [
	^ self context search
]

{ #category : #accessing }
GtSpotterFilterSignal >> streamed [
	^ streamed
]

{ #category : #accessing }
GtSpotterFilterSignal >> streamed: anObject [
	streamed := anObject
]
