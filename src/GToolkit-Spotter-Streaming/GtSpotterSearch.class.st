Class {
	#name : #GtSpotterSearch,
	#superclass : #GtSpotterProtoSearch,
	#instVars : [
		'title',
		'priority',
		'definingMethod'
	],
	#category : #'GToolkit-Spotter-Streaming-Searches'
}

{ #category : #converting }
GtSpotterSearch >> asStreamFor: aSpotterContext [
	<return: #TAsyncStream>
	
	^ self subclassResponsibility
]

{ #category : #accessing }
GtSpotterSearch >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : #initialization }
GtSpotterSearch >> initialize [
	super initialize.
	
	title := 'Untitled'.
	priority := 10
]

{ #category : #accessing }
GtSpotterSearch >> priority [

	^ priority
]

{ #category : #accessing }
GtSpotterSearch >> priority: aNumber [
	priority := aNumber
]

{ #category : #accessing }
GtSpotterSearch >> title [

	^ title
]

{ #category : #accessing }
GtSpotterSearch >> title: aString [
	title := aString
]
