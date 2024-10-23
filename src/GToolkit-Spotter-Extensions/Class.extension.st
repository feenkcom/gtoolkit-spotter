Extension { #name : #Class }

{ #category : #'*GToolkit-Spotter-Extensions' }
Class >> gtSpotterActDefaultFrom: aSpotterElement [
	self gtBrowseFrom: aSpotterElement
]

{ #category : #'*GToolkit-Spotter-Extensions' }
Class >> gtSpotterClassMethodsFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		priority: 15;
		title: 'Class methods';
		search: [ :aContext | 
			(GtPharoIndex current asyncImplementersForWord: aContext searchQuery)
				filter: [ :aCompiledMethod | 
					aCompiledMethod methodClass = self classSide ] ];
		itemName: [ :method | method selector ]
]

{ #category : #'*GToolkit-Spotter-Extensions' }
Class >> gtSpotterMethodsFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		priority: 10;
		title: 'Instance methods';
		search: [ :aContext | 
			(GtPharoIndex current asyncImplementersForWord: aContext searchQuery)
				filter: [ :aCompiledMethod | 
					aCompiledMethod methodClass = self ] ];
		itemName: [ :method | method selector ]
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
	^ aSearch explicit
		priority: 16;
		title: 'Super class methods';
		search: [ :aContext | 
			(GtPharoIndex current asyncImplementersForWord: aContext searchQuery)
				filter: [ :aCompiledMethod | 
					aCompiledMethod methodClass isClassSide and: [
						self classSide inheritsFrom: aCompiledMethod methodClass ] ] ]
]

{ #category : #'*GToolkit-Spotter-Extensions' }
Class >> gtSpotterSuperMethodsFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		priority: 11;
		title: 'Super instance methods';
		search: [ :aContext | 
			(GtPharoIndex current asyncImplementersForWord: aContext searchQuery)
				filter: [ :aCompiledMethod | 
					aCompiledMethod methodClass isInstanceSide and: [
						self inheritsFrom: aCompiledMethod methodClass ] ] ]
]
