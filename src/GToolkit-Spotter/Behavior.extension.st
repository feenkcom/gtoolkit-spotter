Extension { #name : #Behavior }

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterClassInstanceVariablesFor: aSearch [
	<gtSearch>
	self isTrait ifTrue: [ ^ aSearch empty ].
	^ aSearch list
		priority: 25;
		title: 'Class instance variables';
		items: [ self class classLayout allSlots ];
		itemName: [ :each | each name asString ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterCompositionFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 25;
		title: 'Composing traits';
		items: [ self traitComposition allTraits ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterInstanceVariablesFor: aSearch [
	<gtSearch>
	self isTrait ifTrue: [ ^ aSearch empty ].
	^ aSearch list
		priority: 20;
		title: 'Instance variables';
		items: [ self classLayout allSlots ];
		itemName: [ :each | each name asString ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterSpecialSlotsFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 70;
		title: 'Special Slots';
		items: [ self slots select: [:each | each needsFullDefinition]];
		itemName: [ :item | item definitionString ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterSubclassesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 50;
		title: 'All subclasses';
		items: [ self allSubclasses ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterSuperclassesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 40;
		title: 'All superclasses';
		items: [ self allSuperclasses ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterTraitUsersFor: aSearch [
	<gtSearch>
	self isTrait ifFalse: [ ^ aSearch empty ].
	^ aSearch list
		priority: 20;
		title: 'Users';
		items: [ self traitUsers asArray ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterUsedTraitsFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 60;
		title: 'Uses Traits';
		items: [ self traits asArray ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> withMethodsReferTo: aLiteral do: aBlock [
	| specialIndex |
	specialIndex := Smalltalk specialSelectorIndexOrNil: aLiteral.
	self methodsDo: [ :method | 
		((method hasLiteral: aLiteral) 
			or: [ specialIndex notNil and: [ method scanFor: method encoderClass firstSpecialSelectorByte + specialIndex ] ])
				ifTrue: [ aBlock value: method ] ]
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> withThorougMethodsReferTo: aLiteral do: aBlock [
	| specialIndex |
	specialIndex := Smalltalk specialSelectorIndexOrNil: aLiteral.
	self methodsDo: [ :method | 
		(method hasSelector: aLiteral specialSelectorIndex: specialIndex)
					ifTrue: [ aBlock value: method ] ].
]
