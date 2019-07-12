Extension { #name : #FileReference }

{ #category : #'*GToolkit-Spotter' }
FileReference >> gtSpotterForAddressFileFor: aStep [
	<gtSearch>
	self isAddressBookFile
		ifFalse: [ ^ self ].
	aStep listProcessor
		priority: 40;
		title: 'Contacts';
		allCandidates: [ self contactsFromFile ];
		itemName: #fullName;
		filter: GTFilterSubstrings;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
FileReference >> gtSpotterForXMLFileFor: aStep [
	<gtSearch>
	| xmlFileHandle |
	xmlFileHandle := XMLFileSystemFileHandle fileReference: self.
	xmlFileHandle isXMLDocumentFile
		ifFalse: [ ^ self ].
	aStep listProcessor
		priority: 40;
		title: 'XML Document';
		allCandidates:
				[ (XMLDOMParser parseFileNamed: xmlFileHandle path) allElements ];
		itemName: #gtDisplayString;
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
