Extension { #name : #Dictionary }

{ #category : #'*GToolkit-Spotter-Extensions' }
Dictionary >> gtSpotterForKeysFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 15;
		title: 'Keys';
		items: [ self keys ];
		filterBySubstring
]
