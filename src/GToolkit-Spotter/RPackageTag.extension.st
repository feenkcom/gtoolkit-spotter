Extension { #name : #RPackageTag }

{ #category : #'*GToolkit-Spotter' }
RPackageTag >> gtSpotterClassesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 20;
		allCandidates: [ self classes sorted: [ :a :b | a name < b name ] ];
		title: 'Classes';
		filter: GTFilterSubstring
]
