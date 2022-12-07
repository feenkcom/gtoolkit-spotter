Class {
	#name : #GtSpotterContext,
	#superclass : #Object,
	#instVars : [
		'searchQuery'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #initialization }
GtSpotterContext >> initialize [
	super initialize.
	
	searchQuery := ''
]

{ #category : #testing }
GtSpotterContext >> isEmptySearchQuery [
	^ searchQuery isEmpty
]

{ #category : #accessing }
GtSpotterContext >> searchQuery [

	^ searchQuery
]

{ #category : #accessing }
GtSpotterContext >> searchQuery: anObject [
	searchQuery := anObject
]
