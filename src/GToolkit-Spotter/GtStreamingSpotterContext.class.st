Class {
	#name : #GtStreamingSpotterContext,
	#superclass : #Object,
	#instVars : [
		'searchQuery'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #initialization }
GtStreamingSpotterContext >> initialize [
	super initialize.
	
	searchQuery := ''
]

{ #category : #testing }
GtStreamingSpotterContext >> isEmptySearchQuery [
	^ searchQuery isEmpty
]

{ #category : #accessing }
GtStreamingSpotterContext >> searchQuery [

	^ searchQuery
]

{ #category : #accessing }
GtStreamingSpotterContext >> searchQuery: anObject [
	searchQuery := anObject
]
