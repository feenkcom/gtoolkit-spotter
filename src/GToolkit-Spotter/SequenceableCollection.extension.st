Extension { #name : #SequenceableCollection }

{ #category : #'*GToolkit-Spotter' }
SequenceableCollection >> fasterDifferencePreservingOrder: aCollection [
	" this implementation does not preserve the original species of self ! it serves ONE specific use case only "
	| newCollection |
	newCollection := OrderedCollection new: self size.
	self do: [ :each | 
		(aCollection includes: each) 
			ifFalse: [ newCollection add: each ] ].
	^ newCollection
]

{ #category : #'*GToolkit-Spotter' }
SequenceableCollection >> gtItemsSearchFor: aSearch [
	<gtSearch>
	
	^ aSearch list
		priority: 10;
		title: 'Items';
		items: [ self ];
		filterBySubstring;
		itemActLogic: [:anObject :step :spotterElement | 
			spotterElement phlow spawnObject: anObject ];
		withoutItemsLimit
]
