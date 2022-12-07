Extension { #name : #SequenceableCollection }

{ #category : #'*GToolkit-Spotter-Extensions' }
SequenceableCollection >> gtItemsSearchFor: aSearch [
	<gtSearch>
	
	^ aSearch list
		priority: 10;
		title: 'Items';
		items: [ self ];
		filterBySubstring;
		send: [ :anObject | anObject class ];
		sendTool: [ :anObject | anObject class inspectorTool ];
		
		"buttonm itemActLogic: [ :anObject :step :spotterElement |
			anObject class inspect ];"
		withoutItemsLimit
]
