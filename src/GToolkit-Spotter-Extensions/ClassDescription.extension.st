Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-Spotter-Extensions' }
ClassDescription >> gtSpotterPackageFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 50;
		title: 'Package';
		items: [ {self package} ];
		itemName: [ :item | item packageName ];
		filterBySubstring
]
