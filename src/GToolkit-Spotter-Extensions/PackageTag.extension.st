Extension { #name : #PackageTag }

{ #category : #'*GToolkit-Spotter-Extensions' }
PackageTag >> gtSpotterClassesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 20;
		items: [ self classes sorted: [ :a :b | a name < b name ] ];
		title: 'Classes';
		filterBySubstring
]
