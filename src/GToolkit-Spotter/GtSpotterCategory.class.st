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

{ #category : #searches }
GtSpotterCategory >> gtItemsFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: search title;
		priority: 1;
		items: [ candidates asyncSimilarCopy ];
		itemName: [ :eachCandidate | search itemNameFor: eachCandidate ];
		previewElement: [ :eachCandidate | search previewElementFor: eachCandidate ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true;
		withoutItemsLimit
]

{ #category : #searches }
GtSpotterCategory >> gtSpotterActDefaultFrom: aSpotterElement [
	^ GtInspector
		openOn: self items
		from: aSpotterElement
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
