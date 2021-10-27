Extension { #name : #GTInspector }

{ #category : #'*GToolkit-Spotter' }
GTInspector class >> gtSpotterExtensionsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 50;
		allCandidates: [ self inspectorExtendingMethods ];
		title: 'Extensions';
		itemName: [ :each | each gtDisplayString ];
		filter: GtFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
