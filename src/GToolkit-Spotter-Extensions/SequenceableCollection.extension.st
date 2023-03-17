Extension { #name : #SequenceableCollection }

{ #category : #'*GToolkit-Spotter-Extensions' }
SequenceableCollection >> gtItemsSearchFor: aSearch [
	<gtSearch>
	
	^ aSearch list
		priority: 10;
		title: 'Items';
		items: [ self ];
		filterBySubstring;
		withoutItemsLimit
]
