Extension { #name : #MetacelloVersion }

{ #category : #'*GToolkit-Spotter-Extensions' }
MetacelloVersion >> gtSpotterForGroupsFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 2;
		title: 'Groups';
		items: [ self groups ];
		itemName: [ :item | item name ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter-Extensions' }
MetacelloVersion >> gtSpotterForPackagesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 3;
		title: 'Packages';
		items: [ self packages ];
		itemName: [ :item | item file ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]
