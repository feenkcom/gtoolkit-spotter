Extension { #name : #Class }

{ #category : #'*GToolkit-Spotter' }
Class >> gtSpotterActDefaultFrom: aSpotterElement [
	self gtBrowseFrom: aSpotterElement
]

{ #category : #'*GToolkit-Spotter' }
Class >> gtSpotterClassMethodsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 15;
		title: 'Class methods';
		allCandidates: [ self classSide methods ];
		itemName: [ :method | method selector ];
		filter: GtFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
Class >> gtSpotterMethodsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 10;
		title: 'Instance methods';
		allCandidates: [ self methods ];
		itemName: [ :method | method selector ];
		filter: GtFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
Class >> gtSpotterReferenceFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 30;
		title: 'References';
		allCandidates: [ GtPharoIndex current globalVariableReferencesTo: self binding ];
		itemName: [ :method | method gtDisplayString ];
		filter: GtFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
Class >> gtSpotterSuperClassMethodsFor: aStep [
	<gtSearch>
	| superclasses |
	superclasses := self class withAllSuperclasses select: #isMeta.
	aStep listProcessor
		priority: 16;
		title: 'Super class methods';
		allCandidates: [ self classSide allMethods
				select: [ :each | 
					(each methodClass = self classSide) not
						& (superclasses includes: each methodClass) ] ];
		filter: GtFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
Class >> gtSpotterSuperMethodsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 11;
		title: 'Super instance methods';
		allCandidates: [ self allMethods reject: [ :each | each methodClass = self ] ];
		filter: GtFilterSubstring
]
