Extension { #name : #BlElement }

{ #category : #'*GToolkit-Spotter' }
BlElement >> gtSpotterForChildrenFor: aStep [
	<gtSearch>
	^ self hasChildren
		ifTrue: [ 
			aStep listProcessor
				priority: 20;
				allCandidates: [ self allChildrenBreadthFirstSelect: [ :x | true ] ];
				title: 'Children';
				candidatesLimit: Float infinity;
				filter: GTFilterSubstring ]
]
