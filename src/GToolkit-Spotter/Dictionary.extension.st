Extension { #name : #Dictionary }

{ #category : #'*GToolkit-Spotter' }
Dictionary >> gtSpotterForKeysFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 15;
		title: 'Keys';
		allCandidates: [ self keys ];
		candidatesLimit: 5;
		filter: GtFilterSubstring
]
