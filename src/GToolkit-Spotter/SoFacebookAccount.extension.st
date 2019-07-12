Extension { #name : #SoFacebookAccount }

{ #category : #'*GToolkit-Spotter' }
SoFacebookAccount >> gtSpotterAlbumsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 85;
		allCandidates: [ self albums values ];
		itemName: #name;
		title: 'Albums';
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
