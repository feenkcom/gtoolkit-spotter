Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Spotter-Streaming' }
CompiledMethod >> gtSearchForImplementorsFor: aSearch [
	<gtSpotterSearch>

	^ aSearch list
		priority: 10;
		title: 'Implementors';
		items: [ self implementors collect: #compiledMethod ];
		filterBySubstring
]
