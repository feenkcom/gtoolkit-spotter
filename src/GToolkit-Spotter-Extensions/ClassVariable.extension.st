Extension { #name : #ClassVariable }

{ #category : #'*GToolkit-Spotter-Extensions' }
ClassVariable >> gtSpotterForReferencesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 130;
		title: 'References';
		items: [ SystemNavigation default allReferencesTo: self ];
		itemName: [ :method | method gtDisplayString ];
		filterBySubstring
]
