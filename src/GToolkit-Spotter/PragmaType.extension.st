Extension { #name : #PragmaType }

{ #category : #'*GToolkit-Spotter' }
PragmaType >> gtSpotterPragmasFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 40;
		title: 'Pragmas';
		allCandidates: [ self pragmas ];
		itemName: [ :pragma | pragma method printString , ' ' , pragma asString ];
		filter: GTFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
PragmaType >> gtSpotterUsersFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 50;
		title: 'Users';
		filter: GTFilterSubstring
			item:
				[ :filter :context | self users do: [ :sender | filter value: sender ] ]
]
