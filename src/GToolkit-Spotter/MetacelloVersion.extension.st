Extension { #name : #MetacelloVersion }

{ #category : #'*GToolkit-Spotter' }
MetacelloVersion >> gtSpotterForGroupsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 2;
		title: 'Groups';
		allCandidates: [ self groups ];
		itemName: [ :item | item name ];
		filter: GtFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
MetacelloVersion >> gtSpotterForPackagesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 3;
		title: 'Packages';
		allCandidates: [ self packages ];
		itemName: [ :item | item file ];
		filter: GtFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
