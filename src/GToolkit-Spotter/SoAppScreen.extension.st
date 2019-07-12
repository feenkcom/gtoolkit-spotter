Extension { #name : #SoAppScreen }

{ #category : #'*GToolkit-Spotter' }
SoAppScreen >> gtSpotterChildScreensFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 85;
		allCandidates: [ self childScreens ];
		itemName: #label;
		title: 'Screens';
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
