Extension { #name : #Slot }

{ #category : #'*GToolkit-Spotter-Extensions' }
Slot >> gtSpotterAccessesFor: aSearch [
	<gtSearch>
	(aSearch hasPreviousStep
		and: [ (aSearch previousStep origin isKindOf: Class)
				or: [ aSearch origin isKindOf: Class ] ])
		ifTrue: [ ^ aSearch list
				priority: 10;
				title: 'Accesses';
				items: [ SystemNavigation default
						allAccessesTo: self name
						from: aSearch previousStep origin ];
				itemName: [ :each | each asString ];
				filterBySubstring ]
]
