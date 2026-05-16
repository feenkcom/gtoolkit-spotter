Extension { #name : #Slot }

{ #category : #'*GToolkit-Spotter-Extensions' }
Slot >> gtSpotterReferencesFor: aSearch [
	<gtSearch>
	
	^ aSearch list
		priority: 10;
		title: 'References';
		items: [ self owningClass allMethodsAccessingSlot: self ];
		itemName: [ :each | each asString ];
		filterBySubstring
]
