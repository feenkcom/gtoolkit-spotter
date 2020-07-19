Extension { #name : #Collection }

{ #category : #'*GToolkit-Spotter' }
Collection >> gtSpotterItemsFor: aStep [
	<gtSearch>
	| processor |
	(self isEmpty or: [ self size > self gtCollectionSizeThreshold ])
		ifTrue: [ ^ self ].
	processor := aStep previousProcessorFrom: self.
	^ aStep listProcessor
		priority: 10;
		title: processor title;
		candidatesLimit: 100;
		items: [ self
				collect: [ :each | each asGtSpotterCandidateLink value ]
				as: OrderedCollection ];
		itemName: processor itemName;
		itemIcon: processor itemIcon;
		actLogic: processor actLogic;
		itemFilterName: processor itemFilterName;
		filter: processor filter gtListFilter;
		wantsToDisplayOnEmptyQuery: true
]
