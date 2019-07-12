Extension { #name : #FMMetaRepository }

{ #category : #'*GToolkit-Spotter' }
FMMetaRepository >> gtGtSpotterClassesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 10;
		title: 'Classes';
		allCandidates: [ self classes ];
		itemName: [ :class | class fullName ];
		filter: GTFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
FMMetaRepository >> gtGtSpotterPackagesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 20;
		title: 'Packages';
		allCandidates: [ self packages ];
		itemName: [ :example | example fullName ];
		filter: GTFilterSubstring
]
