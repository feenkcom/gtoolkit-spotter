Extension { #name : #ClySpotterModel }

{ #category : #'*GToolkit-Spotter' }
ClySpotterModel >> gtSpotterForCommandsFor: aStep [
	<gtSearch>
	browser
		allContextsDo: [ :each | self commandListProcessorForContext: each step: aStep ]
]

{ #category : #'*GToolkit-Spotter' }
ClySpotterModel >> gtSpotterForGoToFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 10;
		title: 'Go to';
		allCandidates: [ self collectGoToCandidates ];
		itemName: #name;
		itemIcon: #icon;
		candidatesLimit: 10;
		filter: GtFilterSubstring;
		actLogic: [ :assoc :step | 
			step exit.
			assoc activate ]
]
