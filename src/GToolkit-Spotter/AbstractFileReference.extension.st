Extension { #name : #AbstractFileReference }

{ #category : #'*GToolkit-Spotter' }
AbstractFileReference >> gtSpotterForDirectoriesFor: aStep [
	<gtSearch>
	^ self isDirectory
		ifTrue: [ aStep listProcessor
				priority: 10;
				allCandidates: [ self directories ];
				title: 'Directories';
				candidatesLimit: Float infinity;
				itemName: #basename;
				itemIcon: [ GLMUIThemeExtraIcons glamorousFolder ];
				filter: GTFilterSubstring ]
]

{ #category : #'*GToolkit-Spotter' }
AbstractFileReference >> gtSpotterForFilesFor: aStep [
	<gtSearch>
	^ self isDirectory
		ifTrue: [ aStep listProcessor
				priority: 20;
				allCandidates: [ self files ];
				title: 'Files';
				candidatesLimit: Float infinity;
				itemName: #basename;
				itemIcon: [ GLMUIThemeExtraIcons glamorousBrowse ];
				filter: GTFilterSubstring ]
]

{ #category : #'*GToolkit-Spotter' }
AbstractFileReference >> gtSpotterForZipDirectoriesFor: aStep [
	<gtSearch>
	| zipFileSystem |
	self isZipFile
		ifFalse: [ ^ self ].
	aStep listProcessor
		priority: 10;
		allCandidates: [ zipFileSystem := (FileSystem zip: self) open.
			zipFileSystem workingDirectory directories ];
		title: 'Directories';
		candidatesLimit: Float infinity;
		itemName: #basename;
		itemIcon: [ GLMUIThemeExtraIcons glamorousFolder ];
		filter: GTFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
AbstractFileReference >> gtSpotterForZipFilesFor: aStep [
	<gtSearch>
	| zipFileSystem |
	self isZipFile
		ifFalse: [ ^ self ].
	aStep listProcessor
		priority: 10;
		allCandidates: [ zipFileSystem := (FileSystem zip: self) open.
			zipFileSystem workingDirectory files ];
		title: 'Files';
		candidatesLimit: Float infinity;
		itemName: #basename;
		itemIcon: [ GLMUIThemeExtraIcons glamorousBrowse ];
		filter: GTFilterSubstring
]
