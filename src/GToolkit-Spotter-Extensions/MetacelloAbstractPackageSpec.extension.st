Extension { #name : #MetacelloAbstractPackageSpec }

{ #category : #'*GToolkit-Spotter-Extensions' }
MetacelloAbstractPackageSpec >> gtSpotterForIncludesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 1;
		title: 'Includes';
		items: [ self includes ];
		itemName: [ :item | item name ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter-Extensions' }
MetacelloAbstractPackageSpec >> gtSpotterForRequiresFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 2;
		title: 'Requires';
		items: [ self requires ];
		itemName: [ :item | item name ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]
