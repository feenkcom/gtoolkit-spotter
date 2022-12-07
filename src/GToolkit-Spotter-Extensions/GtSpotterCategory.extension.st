Extension { #name : #GtSpotterCategory }

{ #category : #'*GToolkit-Spotter-Extensions' }
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

{ #category : #'*GToolkit-Spotter-Extensions' }
GtSpotterCategory >> gtSpotterActDefaultFrom: aSpotterElement [
	^ GtInspector
		openOn: self items
		from: aSpotterElement
]
