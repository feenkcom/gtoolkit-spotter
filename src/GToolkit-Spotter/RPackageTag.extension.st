Extension { #name : #RPackageTag }

{ #category : #'*GToolkit-Spotter' }
RPackageTag >> gtSpotterClassesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 20;
		items: [ self classes sorted: [ :a :b | a name < b name ] ];
		title: 'Classes';
		filterBySubstring
]
