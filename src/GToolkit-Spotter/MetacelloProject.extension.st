Extension { #name : #MetacelloProject }

{ #category : #'*GToolkit-Spotter' }
MetacelloProject >> gtSpotterForVersionsFor: aStep [
	<gtSearch>
	self flag: #maybeRewriteForDirectStreaming.
	aStep listProcessor
		priority: 1;
		title: 'Versions';
		allCandidates: [ (#(stableVersion currentVersion bleedingEdge development)
				collect: [ :each | 
					[ self perform: each ]
						on: Error
						do: [ nil ] ]) reject: [ :each | each isNil ] ];
		itemName: [ :version | version versionString ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
