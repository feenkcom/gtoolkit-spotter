Class {
	#name : #GtStreamingSpotterCategoryStart,
	#superclass : #Object,
	#instVars : [
		'search',
		'context',
		'candidates'
	],
	#category : #'GToolkit-Spotter-Streaming-Model'
}

{ #category : #accessing }
GtStreamingSpotterCategoryStart >> context [

	^ context
]

{ #category : #printing }
GtStreamingSpotterCategoryStart >> gtDisplayOn: aStream [
	aStream
		nextPutAll: search title
]

{ #category : #searches }
GtStreamingSpotterCategoryStart >> gtItemsFor: aSearch [
	<gtSpotterSearch>
	
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

{ #category : #accessing }
GtStreamingSpotterCategoryStart >> search [

	^ search
]

{ #category : #initialization }
GtStreamingSpotterCategoryStart >> search: aSearch context: aSearchContext [
	search := aSearch.
	context := aSearchContext.
	candidates := (search asStreamFor: context) cached
]
