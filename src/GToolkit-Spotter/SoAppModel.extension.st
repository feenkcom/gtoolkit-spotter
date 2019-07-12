Extension { #name : #SoAppModel }

{ #category : #'*GToolkit-Spotter' }
SoAppModel >> gtSpotterOverviewScreensFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 85;
		allCandidates: [ self rootScreens flatCollect: #childScreens ];
		itemName: #label;
		title: 'Screens';
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
