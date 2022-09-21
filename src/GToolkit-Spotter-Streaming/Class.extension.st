Extension { #name : #Class }

{ #category : #'*GToolkit-Spotter-Streaming' }
Class >> gtSearchMethodsFor: aSearch [
	<gtSearch>
	
	^ aSearch list
		priority: 10;
		title: 'Instance methods';
		items: [ self methods ];
		filterBySubstring
]
