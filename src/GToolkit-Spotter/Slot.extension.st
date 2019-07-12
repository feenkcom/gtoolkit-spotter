Extension { #name : #Slot }

{ #category : #'*GToolkit-Spotter' }
Slot >> gtSpotterAccessesFor: aStep [
	<gtSearch>
	(aStep hasPreviousStep
		and: [ (aStep previousStep origin isKindOf: Class)
				or: [ aStep origin isKindOf: Class ] ])
		ifTrue: [ aStep listProcessor
				priority: 10;
				title: 'Accesses';
				allCandidates: [ SystemNavigation default
						allAccessesTo: self name
						from: aStep previousStep origin ];
				itemName: [ :each | each asString ];
				filter: GTFilterSubstring ]
]
