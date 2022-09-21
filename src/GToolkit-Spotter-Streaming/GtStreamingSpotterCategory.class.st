Class {
	#name : #GtStreamingSpotterCategory,
	#superclass : #Object,
	#instVars : [
		'search',
		'context',
		'candidates'
	],
	#category : #'GToolkit-Spotter-Streaming-Model'
}

{ #category : #accessing }
GtStreamingSpotterCategory >> context [

	^ context
]

{ #category : #printing }
GtStreamingSpotterCategory >> gtDisplayOn: aStream [
	aStream
		nextPutAll: search title
]

{ #category : #searches }
GtStreamingSpotterCategory >> gtItemsFor: aSearch [
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
GtStreamingSpotterCategory >> gtSpotterActDefaultFrom: aSpotterElement [
	^ GtInspector
		openOn: self items
		from: aSpotterElement
]

{ #category : #accessing }
GtStreamingSpotterCategory >> items [
	^ candidates asyncSimilarCopy
]

{ #category : #accessing }
GtStreamingSpotterCategory >> search [

	^ search
]

{ #category : #initialization }
GtStreamingSpotterCategory >> search: aSearch context: aSearchContext [
	search := aSearch.
	context := aSearchContext.
	candidates := (search asStreamFor: context) cached
]
