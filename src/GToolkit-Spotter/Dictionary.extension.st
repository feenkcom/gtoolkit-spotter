Extension { #name : #Dictionary }

{ #category : #'*GToolkit-Spotter' }
Dictionary >> gtSpotterForKeysFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 15;
		title: 'Keys';
		items: [ self keys ];
		candidatesLimit: 5;
		filterBySubstring
]
