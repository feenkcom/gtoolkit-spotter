Extension { #name : #ClassDescription }

{ #category : #'*GToolkit-Spotter' }
ClassDescription >> gtSpotterPackageFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 50;
		title: 'Package';
		allCandidates: [ {self package} ];
		itemName: [ :item | item packageName ];
		itemIcon: #systemIcon;
		filter: GtFilterSubstring
]
