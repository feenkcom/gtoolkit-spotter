Extension { #name : #Morph }

{ #category : #'*GToolkit-Spotter' }
Morph >> gtSpotterForKeysFor: aStep [
	<gtSearch>
	(self hasProperty: #kmDispatcher)
		ifFalse: [ ^ self ].
	self kmDispatcher spotterForKeysFor: aStep
]

{ #category : #'*GToolkit-Spotter' }
Morph >> gtSpotterForSubmorphsFor: aStep [
	<gtSearch>
	self submorphs ifNil: [ ^ self ].
	aStep listProcessor
		priority: 10;
		title: 'Submorphs';
		allCandidates: [ self submorphs ];
		candidatesLimit: 5;
		filter: GTFilterSubstring
]
