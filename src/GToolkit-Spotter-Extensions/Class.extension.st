Extension { #name : #Class }

{ #category : #'*GToolkit-Spotter-Extensions' }
Class >> gtSpotterActDefaultFrom: aSpotterElement [
	self gtBrowseFrom: aSpotterElement
]

{ #category : #'*GToolkit-Spotter-Extensions' }
Class >> gtSpotterClassMethodsFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 15;
		title: 'Class methods';
		items: [ self classSide methods ];
		itemName: [ :method | method selector ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter-Extensions' }
Class >> gtSpotterMethodsFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 10;
		title: 'Instance methods';
		items: [ self methods ];
		itemName: [ :method | method selector ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter-Extensions' }
Class >> gtSpotterReferenceFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 30;
		title: 'References';
		items: [ GtPharoIndex current globalVariableReferencesTo: self binding ];
		itemName: [ :method | method gtDisplayString ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter-Extensions' }
Class >> gtSpotterSuperClassMethodsFor: aSearch [
	<gtSearch>
	| superclasses |
	superclasses := self class withAllSuperclasses select: #isMeta.
	^ aSearch list
		priority: 16;
		title: 'Super class methods';
		items: [ self classSide allMethods
				select: [ :each | 
					(each methodClass = self classSide) not
						& (superclasses includes: each methodClass) ] ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter-Extensions' }
Class >> gtSpotterSuperMethodsFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 11;
		title: 'Super instance methods';
		items: [ self allMethods reject: [ :each | each methodClass = self ] ];
		filterBySubstring
]
