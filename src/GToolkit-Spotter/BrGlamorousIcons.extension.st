Extension { #name : 'BrGlamorousIcons' }

{ #category : '*GToolkit-Spotter' }
BrGlamorousIcons class >> spotterForPixelIconFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Pixel Icons';
		priority: 1;
		allCandidates: [ GtSpotterPixelIconPreview 
			library: self allForms: self allIcons ];
		itemName: #iconSelector;
		filter: GtFilterSubstring
]
