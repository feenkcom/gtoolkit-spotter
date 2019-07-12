Extension { #name : #GTSelector }

{ #category : #'*GToolkit-Spotter' }
GTSelector >> gtSpotterImplementorsFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 40;
		title: 'Implementors';
		filter: GTFilterSubstring
			item: [ :filter :context | self implementors do: filter ];
		keyBinding: $m meta
]

{ #category : #'*GToolkit-Spotter' }
GTSelector >> gtSpotterUsersFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 50;
		title: 'Senders';
		filter: GTFilterSubstring
			item:
				[ :filter :context | self senders do: [ :sender | filter value: sender compiledMethod ] ];
		keyBinding: $n meta
]
