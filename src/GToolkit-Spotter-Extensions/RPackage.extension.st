Extension { #name : #RPackage }

{ #category : #'*GToolkit-Spotter-Extensions' }
RPackage >> gtSpotterActDefaultFrom: anElement [
	self gtBrowseFrom: anElement
]

{ #category : #'*GToolkit-Spotter-Extensions' }
RPackage >> gtSpotterClassesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 20;
		items: [ self definedClasses sorted: [ :a :b | a name < b name ] ];
		title: 'Classes';
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter-Extensions' }
RPackage >> gtSpotterExtensionMethodsFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 30;
		items: [ self extensionMethods ];
		title: 'Extension Methods';
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter-Extensions' }
RPackage >> gtSpotterMonticelloPackageFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 41;
		title: 'Monticello Package';
		items: [ self mcPackage ifNotNil: [ :mcPackage | Array with: mcPackage ] ifNil: [ #() ] ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter-Extensions' }
RPackage >> gtSpotterMonticelloWorkingCopyFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 42;
		title: 'Monticello Working Copy';
		items: [ self mcPackage
				ifNotNil: [ :mcPackage | Array with: mcPackage workingCopy ]
				ifNil: [ #() ] ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter-Extensions' }
RPackage >> gtSpotterTagsFor: aSearch [
	<gtSearch>
	self tags size <= 1 ifTrue: [ ^ aSearch empty ].
	^ aSearch list
		priority: 20;
		items: [ self tags sorted: [ :a :b | a name < b name ] ];
		title: 'Tags';
		itemName: [ :item | item name ];
		filterBySubstring
]
