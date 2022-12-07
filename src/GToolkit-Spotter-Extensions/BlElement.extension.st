Extension { #name : #BlElement }

{ #category : #'*GToolkit-Spotter-Extensions' }
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
