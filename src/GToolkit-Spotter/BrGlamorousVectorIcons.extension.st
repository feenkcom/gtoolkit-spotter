Extension { #name : #BrGlamorousVectorIcons }

{ #category : #'*GToolkit-Spotter' }
BrGlamorousVectorIcons class >> spotterForVectorIconFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Vector Icons';
		priority: 1;
		allCandidates: [ GtSpotterVectorIconPreviewStencil 
			library: BrGlamorousVectorIcons allIcons: BrGlamorousVectorIcons allIcons ];
		itemName: #iconSelector;
		filter: GTFilterSubstring
]
