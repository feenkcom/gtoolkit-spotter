Extension { #name : #MenuMorph }

{ #category : #'*GToolkit-Spotter' }
MenuMorph >> gtSpotterItemsFor: aStep [
	<gtSearch>
	self flag: #refactoringViolationForSpotterActDefault:.
	^ aStep listProcessor
		priority: 10;
		title: 'Items';
		candidatesLimit: Float infinity;
		allCandidates: [ self items ];
		itemName: #contents;
		itemIcon: [ :item | item icon ];
		actLogic: [ :item :step | 
			item hasSubMenu
				ifTrue: [ step diveIn ]
				ifFalse: [ item spotterActDefault.
					step exit ] ];
		filter: GTFilterSubstring
]
