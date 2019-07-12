Extension { #name : #SoBrowser }

{ #category : #'*GToolkit-Spotter' }
SoBrowser >> gtSpotterCookiesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 85;
		allCandidates: [ self allCookies ];
		itemName: #name;
		title: 'Cookies';
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
SoBrowser >> gtSpotterPageVisitsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 85;
		allCandidates: [ self allPageVisits ];
		itemName: #urlString;
		title: 'URLs';
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
