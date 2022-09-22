Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Spotter' }
AbstractFileReference >> gtSpotterForAddressFileFor: aSearch [
	<gtSearch>
	self isAddressBookFile ifFalse: [ ^ aSearch empty ].
	^ aSearch list
		priority: 40;
		title: 'Contacts';
		items: [ self contactsFromFile ];
		itemName: #fullName;
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
AbstractFileReference >> gtSpotterForDirectoriesFor: aSearch [
	<gtSearch>
	^ self isDirectory
		ifFalse: [ aSearch empty ]
		ifTrue: [ aSearch list
				priority: 10;
				items: [ self directories ];
				title: 'Directories';
				itemsLimit: Float infinity;
				itemName: #basename;
				filterBySubstring ]
]

{ #category : #'*GToolkit-Spotter' }
AbstractFileReference >> gtSpotterForFilesFor: aSearch [
	<gtSearch>
	^ self isDirectory
		ifFalse: [ aSearch empty ]
		ifTrue: [ aSearch list
				priority: 20;
				items: [ self files ];
				title: 'Files';
				itemsLimit: Float infinity;
				itemName: #basename;
				filterBySubstring ]
]

{ #category : #'*GToolkit-Spotter' }
AbstractFileReference >> gtSpotterForXMLFileFor: aSearch [
	<gtSearch>
	| xmlFileHandle |
	xmlFileHandle := XMLFileSystemFileHandle fileReference: self.
	xmlFileHandle isXMLDocumentFile ifFalse: [ ^ aSearch empty ].
	^ aSearch list
		priority: 40;
		title: 'XML Document';
		items: [ (XMLDOMParser parseFileNamed: xmlFileHandle path) allElements ];
		itemName: #gtDisplayString;
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
AbstractFileReference >> gtSpotterForZipDirectoriesFor: aSearch [
	<gtSearch>
	| zipFileSystem |
	self isZipFile ifFalse: [ ^ aSearch empty ].
	^ aSearch list
		title: 'Directories';
		priority: 10;
		items: [ zipFileSystem := (FileSystem zip: self) open.
			zipFileSystem workingDirectory directories ];
		itemsLimit: Float infinity;
		itemName: #basename;
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter' }
AbstractFileReference >> gtSpotterForZipFilesFor: aSearch [
	<gtSearch>
	| zipFileSystem |
	self isZipFile ifFalse: [ ^ aSearch empty ].
	^ aSearch list
		title: 'Files';
		priority: 10;
		items: [ zipFileSystem := (FileSystem zip: self) open.
			zipFileSystem workingDirectory files ];
		itemName: #basename;
		itemsLimit: Float infinity;
		filterBySubstring
]
