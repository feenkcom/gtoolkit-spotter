Extension { #name : #GtABAddressBook }

{ #category : #'*GToolkit-Spotter' }
GtABAddressBook >> gtGtSpotterForAddressesFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 10;
		title: 'Addresses' translated;
		allCandidates: [ (self contacts collect: #address as: Set) asOrderedCollection ];
		candidatesLimit: 7;
		itemName: [ :each | each city , ', ' , each country ];
		matchSubstrings
]

{ #category : #'*GToolkit-Spotter' }
GtABAddressBook >> gtGtSpotterForPeopleFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 5;
		title: 'People';
		allCandidates: [ self contacts ];
		filter: GTFilterSubstrings;
		candidatesLimit: 7;
		itemName:
				[ :aContact | aContact lastName asUppercase , ', ' , aContact firstName ]
]

{ #category : #'*GToolkit-Spotter' }
GtABAddressBook >> gtGtSpotterForTelephonesFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 15;
		title: 'Telephones' translated;
		allCandidates: [ self contacts collect: [ :aContact | aContact address telephone ] ];
		matchSubstrings
]
