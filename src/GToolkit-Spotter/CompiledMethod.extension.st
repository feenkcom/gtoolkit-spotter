Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Spotter' }
CompiledMethod >> gtSpotterActDefaultFrom: anElement [
	self gtBrowseFrom: anElement
]

{ #category : #'*GToolkit-Spotter' }
CompiledMethod >> gtSpotterForBytecodesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 15;
		title: 'Bytecode';
		items: [ self symbolicBytecodes ];
		itemName: #printString;
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter' }
CompiledMethod >> gtSpotterForImplementorsFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 10;
		title: 'Implementors';
		items: [ self implementors collect: #compiledMethod ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter' }
CompiledMethod >> gtSpotterForMessagesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 12;
		title: 'Messages';
		items: [ self messages asSortedCollection
				collect: [ :each | GtSelector new name: each ] ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter' }
CompiledMethod >> gtSpotterForSendersFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 11;
		title: 'Senders';
		items: [ self senders collect: #compiledMethod ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter' }
CompiledMethod >> gtSpotterMethodClassFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 50;
		items: [ {self methodClass} ];
		title: 'Class';
		filterBySubstring
]
