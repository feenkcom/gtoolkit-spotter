Extension { #name : #SoPod }

{ #category : #'*GToolkit-Spotter' }
SoPod >> gtSpotterAccountsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 85;
		allCandidates: [ self accounts ];
		itemName: #gtDisplayString;
		title: 'Accounts';
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
SoPod >> gtSpotterBrowsersFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 85;
		allCandidates: [ self browsers ];
		itemName: #name;
		title: 'Browsers';
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
SoPod >> gtSpotterEmailsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 85;
		allCandidates: [ (self accounts flatCollect: #emails as: Set) asOrderedCollection ];
		itemName: #gtDisplayString;
		title: 'Emails';
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
