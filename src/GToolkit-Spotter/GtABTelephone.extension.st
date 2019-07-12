Extension { #name : #GtABTelephone }

{ #category : #'*GToolkit-Spotter' }
GtABTelephone >> gtSpotterForContactsFor: aStep [
	<gtSearch>
	(aStep hasPreviousNavigationFromClass: GtABAddressBook)
		ifFalse: [ ^ self ].
	^ aStep listProcessor
		priority: 10;
		title: 'Contacts';
		candidatesLimit: Float infinity;
		allCandidates: [ aStep previousStep origin contactsWithTelephone: self number ];
		matchSubstring
]
