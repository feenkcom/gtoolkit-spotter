Extension { #name : #Behavior }

{ #category : #'*GToolkit-Spotter-Streaming' }
Behavior >> gtSearchInstanceVariablesFor: aSearch [
	<gtSpotterSearch>
	self isTrait
		ifTrue: [ ^ aSearch empty ].
	^ aSearch list
		priority: 20;
		title: 'Instance variables';
		items: [ self classLayout allSlots ];
		itemName: [ :each | each name asString ];
		filterBySubstring
]
