Extension { #name : #XMLNodeWithElements }

{ #category : #'*GToolkit-Spotter' }
XMLNodeWithElements >> gtSpotterForAllElementsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 40;
		title: 'All elements';
		allCandidates: [ self allElements ];
		itemName: #gtDisplayString;
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
XMLNodeWithElements >> gtSpotterForDirectElementsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 40;
		title: 'Direct elements';
		allCandidates: [ self elements ];
		itemName: #gtDisplayString;
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
