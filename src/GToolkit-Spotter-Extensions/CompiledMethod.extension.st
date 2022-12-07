Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Spotter-Extensions' }
CompiledMethod >> gtItemsSearchFor: aSearch [
	"the search for collection items does not apply for compiled methods"
	^ aSearch empty
]

{ #category : #'*GToolkit-Spotter-Extensions' }
CompiledMethod >> gtSpotterActDefaultFrom: anElement [
	self gtBrowseFrom: anElement
]

{ #category : #'*GToolkit-Spotter-Extensions' }
CompiledMethod >> gtSpotterForBytecodesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 15;
		title: 'Bytecode';
		items: [ self symbolicBytecodes ];
		itemName: #printString;
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter-Extensions' }
CompiledMethod >> gtSpotterForImplementorsFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 10;
		title: 'Implementors';
		items: [ self implementors collect: #compiledMethod ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter-Extensions' }
CompiledMethod >> gtSpotterForMessagesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 12;
		title: 'Messages';
		items: [ self messages asSortedCollection
				collect: [ :each | GtSelector new name: each ] ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter-Extensions' }
CompiledMethod >> gtSpotterForSendersFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 11;
		title: 'Senders';
		items: [ self senders collect: #compiledMethod ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter-Extensions' }
CompiledMethod >> gtSpotterMethodClassFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 50;
		items: [ {self methodClass} ];
		title: 'Class';
		filterBySubstring
]
