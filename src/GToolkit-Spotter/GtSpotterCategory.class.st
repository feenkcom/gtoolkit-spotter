Class {
	#name : #GtSpotterCategory,
	#superclass : #Object,
	#instVars : [
		'search',
		'context',
		'candidates'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #accessing }
GtSpotterCategory >> context [

	^ context
]

{ #category : #printing }
GtSpotterCategory >> gtDisplayOn: aStream [
	aStream
		nextPutAll: search title
]

{ #category : #accessing }
GtSpotterCategory >> items [
	^ candidates asyncSimilarCopy
]

{ #category : #accessing }
GtSpotterCategory >> search [
	^ search
]

{ #category : #initialization }
GtSpotterCategory >> search: aSearch context: aSearchContext [
	search := aSearch.
	context := aSearchContext.
	candidates := (search asStreamFor: context) cached
]
