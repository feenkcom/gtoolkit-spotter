Extension { #name : #BrGlamorousVectorIcons }

{ #category : #'*GToolkit-Spotter' }
BrGlamorousVectorIcons class >> gtSpotterForVectorIconFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Vector Icons';
		priority: 1;
		items: [ GtSpotterVectorIconPreview
				library: BrGlamorousVectorIcons
				allIcons: BrGlamorousVectorIcons allIcons ];
		itemName: #iconSelector;
		filterBySubstring
]
