Class {
	#name : #GtStreamingSpotter,
	#superclass : #Object,
	#instVars : [
		'steps'
	],
	#category : #'GToolkit-Spotter-Streaming-Model'
}

{ #category : #'instance creation' }
GtStreamingSpotter class >> on: anObject [
	^ self new initializeWith: anObject
]

{ #category : #initialization }
GtStreamingSpotter >> initializeWith: anObject [
	steps := OrderedCollection new.
	steps add: (GtStreamingSpotterStep new initializeWithSpotter: self origin: anObject)
]
