Extension { #name : 'GTSpotterIterator' }

{ #category : '*GToolkit-Spotter' }
GTSpotterIterator >> gtItemsFor: aView [
	<gtView>
	items ifNil: [ ^ aView empty ].
	^ aView forward
		title: 'Candidates';
		object: [ self items ];
		view: #gtItemsFor:
]
