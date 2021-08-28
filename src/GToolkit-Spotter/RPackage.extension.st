Extension { #name : 'RPackage' }

{ #category : '*GToolkit-Spotter' }
RPackage >> gtSpotterActDefaultFrom: anElement [
	self gtBrowseFrom: anElement
]

{ #category : '*GToolkit-Spotter' }
RPackage >> gtSpotterClassesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 20;
		allCandidates: [ self definedClasses sorted: [ :a :b | a name < b name ] ];
		title: 'Classes';
		filter: GtFilterSubstring
]

{ #category : '*GToolkit-Spotter' }
RPackage >> gtSpotterExtensionMethodsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 30;
		allCandidates: [ self extensionMethods ];
		title: 'Extension Methods';
		filter: GtFilterSubstring
]

{ #category : '*GToolkit-Spotter' }
RPackage >> gtSpotterMonticelloPackageFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 41;
		title: 'Monticello Package';
		allCandidates: [ self mcPackage
				ifNotNil: [ :mcPackage | Array with: mcPackage ]
				ifNil: [ #() ] ];
		itemIcon: [ Smalltalk ui icons iconNamed: #monticelloPackageIcon ];
		filter: GtFilterSubstring
]

{ #category : '*GToolkit-Spotter' }
RPackage >> gtSpotterMonticelloWorkingCopyFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 42;
		title: 'Monticello Working Copy';
		allCandidates: [ self mcPackage
				ifNotNil: [ :mcPackage | Array with: mcPackage workingCopy ]
				ifNil: [ #() ] ];
		itemIcon: [ Smalltalk ui icons iconNamed: #versionControlIcon ];
		filter: GtFilterSubstring
]

{ #category : '*GToolkit-Spotter' }
RPackage >> gtSpotterTagsFor: aStep [
	<gtSearch>
	self classTags size <= 1
		ifTrue: [ ^ self ].
	aStep listProcessor
		priority: 20;
		allCandidates: [ self classTags sorted: [ :a :b | a name < b name ] ];
		title: 'Tags';
		itemName: [ :item | item name ];
		filter: GtFilterSubstring
]
