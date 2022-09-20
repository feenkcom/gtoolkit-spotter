Class {
	#name : #GtSpotterProtoSearch,
	#superclass : #Object,
	#instVars : [
		'title',
		'priority',
		'definingMethod'
	],
	#category : #'GToolkit-Spotter-Streaming-Searches'
}

{ #category : #initialization }
GtSpotterProtoSearch >> definingMethod [
	^ definingMethod
]

{ #category : #initialization }
GtSpotterProtoSearch >> definingMethod: aCompiledMethod [
	definingMethod := aCompiledMethod
]

{ #category : #'api - search' }
GtSpotterProtoSearch >> empty [
	^ GtSpotterEmptySearch new
]

{ #category : #'api - search' }
GtSpotterProtoSearch >> explicit [
	^ GtSpotterExplicitSearch new
]

{ #category : #initialization }
GtSpotterProtoSearch >> initialize [
	super initialize.
	
	title := 'Untitled'.
	priority := 10
]

{ #category : #testing }
GtSpotterProtoSearch >> isBroken [
	^ false
]

{ #category : #'api - search' }
GtSpotterProtoSearch >> list [
	^ GtSpotterListSearch new
]

{ #category : #accessing }
GtSpotterProtoSearch >> priority [

	^ priority
]

{ #category : #'api - configuration' }
GtSpotterProtoSearch >> priority: aNumber [
	priority := aNumber
]

{ #category : #accessing }
GtSpotterProtoSearch >> title [

	^ title
]

{ #category : #'api - configuration' }
GtSpotterProtoSearch >> title: aString [
	title := aString
]
