Extension { #name : #MetacelloProject }

{ #category : #'*GToolkit-Spotter-Extensions' }
MetacelloProject >> gtSpotterForVersionsFor: aSearch [
	<gtSearch>
	self flag: #maybeRewriteForDirectStreaming.
	^ aSearch list
		priority: 1;
		title: 'Versions';
		items: [ (#(stableVersion currentVersion bleedingEdge development)
				collect: [ :each | [ self perform: each ] on: Error do: [ nil ] ])
				reject: [ :each | each isNil ] ];
		itemName: [ :version | version versionString ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]
