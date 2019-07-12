Extension { #name : #GtABAddress }

{ #category : #'*GToolkit-Spotter' }
GtABAddress >> gtGtSpotterForPeopleFor: aStep [
	<gtSearch>
	(aStep hasPreviousNavigationFromClass: GtABAddressBook)
		ifFalse: [ ^ self ].
	^ aStep listProcessor
		priority: 10;
		title: 'People';
		itemName: [ :contact | contact fullName ];
		allCandidates: [ aStep previousStep origin contactsWithAddress: self ];
		candidatesLimit: 10;
		matchSubstrings
]
