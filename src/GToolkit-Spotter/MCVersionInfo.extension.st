Extension { #name : #MCVersionInfo }

{ #category : #'*GToolkit-Spotter' }
MCVersionInfo >> gtSpotterAncestorsFor: aStep [
	<gtSearch>
	self flag: 'rewrite for direct streaming - get rid of recursion'.
	aStep listProcessor
		priority: 1;
		title: 'Ancestors';
		allCandidates: [ self allAncestors ];
		filter: GTFilterSubstring
]
