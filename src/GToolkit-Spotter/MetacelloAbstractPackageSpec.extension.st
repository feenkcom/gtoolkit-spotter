Extension { #name : #MetacelloAbstractPackageSpec }

{ #category : #'*GToolkit-Spotter' }
MetacelloAbstractPackageSpec >> gtSpotterForIncludesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 1;
		title: 'Includes';
		allCandidates: [ self includes ];
		itemName: [ :item | item name ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
MetacelloAbstractPackageSpec >> gtSpotterForRequiresFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 2;
		title: 'Requires';
		allCandidates: [ self requires ];
		itemName: [ :item | item name ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
