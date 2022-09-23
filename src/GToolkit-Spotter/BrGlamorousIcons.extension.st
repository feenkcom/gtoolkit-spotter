Extension { #name : #BrGlamorousIcons }

{ #category : #'*GToolkit-Spotter' }
BrGlamorousIcons class >> gtSpotterForPixelIconFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Pixel Icons';
		priority: 1;
		items: [ GtSpotterPixelIconPreview library: self allForms: self allIcons ];
		itemName: #iconSelector;
		filterBySubstring
]
