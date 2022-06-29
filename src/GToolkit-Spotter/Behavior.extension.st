Extension { #name : #Behavior }

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterClassInstanceVariablesFor: aStep [
	<gtSearch>
	self isTrait
		ifTrue: [ ^ self ].
	^ aStep listProcessor
		priority: 25;
		title: 'Class instance variables';
		allCandidates: [ self class classLayout allSlots ];
		itemName: [ :each | each name asString ];
		filter: GtFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterCompositionFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 25;
		title: 'Composing traits';
		allCandidates: [ self traitComposition allTraits ];
		itemIcon: #systemIcon;
		filter: GtFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterInstanceVariablesFor: aStep [
	<gtSearch>
	self isTrait
		ifTrue: [ ^ self ].
	aStep listProcessor
		priority: 20;
		title: 'Instance variables';
		allCandidates: [ self classLayout allSlots ];
		itemName: [ :each | each name asString ];
		filter: GtFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterSubclassesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 50;
		title: 'All subclasses';
		allCandidates: [ self allSubclasses ];
		itemIcon: #systemIcon;
		filter: GtFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterSuperclassesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 40;
		title: 'All superclasses';
		allCandidates: [ self allSuperclasses ];
		itemIcon: #systemIcon;
		filter: GtFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterTraitUsersFor: aStep [
	<gtSearch>
	self isTrait
		ifFalse: [ ^ self ].
	aStep listProcessor
		priority: 20;
		title: 'Users';
		allCandidates: [ self traitUsers asArray ];
		itemIcon: #systemIcon;
		filter: GtFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterUsedSlotsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 70;
		title: 'Special Slots';
		allCandidates: [ self slots select: [ :slot | slot isSpecial ] ];
		itemName: [ :item | item definitionString ];
		filter: GtFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> gtSpotterUsedTraitsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 60;
		title: 'Uses Traits';
		allCandidates: [ self traits asArray ];
		itemIcon: #systemIcon;
		filter: GtFilterSubstring
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
