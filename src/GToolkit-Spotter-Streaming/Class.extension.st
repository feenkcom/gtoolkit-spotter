Extension { #name : #Class }

{ #category : #'*GToolkit-Spotter-Streaming' }
Class >> gtSearchMethodsFor: aSearch [
	<gtSpotterSearch>
	
	^ aSearch list
		priority: 10;
		title: 'Instance methods';
		items: [ self methods ];
		filterBySubstring
]
