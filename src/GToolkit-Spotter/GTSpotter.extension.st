Extension { #name : #GTSpotter }

{ #category : #'*GToolkit-Spotter' }
GTSpotter class >> gtSpotterExtensionsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 50;
		allCandidates: [ self spotterExtendingMethods ];
		title: 'Extensions';
		itemName: [ :each | each gtDisplayString ];
		filter: GtFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
