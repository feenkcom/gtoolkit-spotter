Extension { #name : #BlElement }

{ #category : #'*GToolkit-Spotter' }
BlElement >> gtSpotterForChildrenFor: aSearch [
	<gtSearch>
	^ self hasChildren
		ifTrue: [ aSearch list
				priority: 20;
				items: [ self allChildrenBreadthFirstSelect: [ :x | true ] ];
				title: 'Children';
				withoutItemsLimit;
				filterBySubstring ]
]
