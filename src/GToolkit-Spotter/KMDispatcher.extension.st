Extension { #name : #KMDispatcher }

{ #category : #'*GToolkit-Spotter' }
KMDispatcher >> gtSpotterForKeysFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 15;
		title: 'Keys';
		allCandidates: [ (self gtAllKeyCategoryPairs collect: #key) asOrderedCollection ];
		itemName: [ :aKeymap | 
			aKeymap shortcut gtDisplayString
				, (aKeymap name ifNil: [ '' ] ifNotNil: [ ' [' , aKeymap name , ']' ]) ];
		candidatesLimit: 5;
		filter: GTFilterSubstrings
]
