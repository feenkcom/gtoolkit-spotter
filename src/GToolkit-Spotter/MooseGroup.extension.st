Extension { #name : #MooseGroup }

{ #category : #'*GToolkit-Spotter' }
MooseGroup >> gtSpotterItemsFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 10;
		title: 'Items';
		candidatesLimit: 50;
		allCandidates: [ self entities ];
		itemName: [ :each | each gtDisplayString ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
