Extension { #name : #BrGlamorousVectorIcons }

{ #category : #'*GToolkit-Spotter' }
BrGlamorousVectorIcons class >> spotterForVectorIconFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Vector Icons';
		priority: 1;
		allCandidates: [ self allIcons ];
		itemName: #key;
		itemIcon: [ :anAssoc | anAssoc value ];
		filter: GTFilterSubstring;
		actLogic: [ :item :step | 
			step exit.
			(BrGlamorousVectorIcons class >> item key) gtInspect ]
]
