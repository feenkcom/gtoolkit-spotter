Extension { #name : #CompiledMethod }

{ #category : #'*GToolkit-Spotter' }
CompiledMethod >> gtSpotterForBytecodesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 15;
		title: 'Bytecode';
		allCandidates: [ self symbolicBytecodes ];
		itemName: #printString;
		filter: GTFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
CompiledMethod >> gtSpotterForImplementorsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 10;
		title: 'Implementors';
		allCandidates: [ self implementors collect: #compiledMethod ];
		filter: GTFilterSubstring;
		keyBinding: $m command
]

{ #category : #'*GToolkit-Spotter' }
CompiledMethod >> gtSpotterForMessagesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 12;
		title: 'Messages';
		allCandidates: [ self messages asSortedCollection
				collect: [ :each | GTSelector new name: each ] ];
		filter: GTFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
CompiledMethod >> gtSpotterForSendersFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 11;
		title: 'Senders';
		allCandidates: [ self senders collect: #compiledMethod ];
		filter: GTFilterSubstring;
		keyBinding: $n command
]

{ #category : #'*GToolkit-Spotter' }
CompiledMethod >> gtSpotterMethodClassFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 50;
		allCandidates: [ {self methodClass} ];
		title: 'Class';
		filter: GTFilterSubstring;
		itemIcon: #systemIcon
]
