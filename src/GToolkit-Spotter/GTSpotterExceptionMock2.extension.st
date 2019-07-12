Extension { #name : #GTSpotterExceptionMock2 }

{ #category : #'*GToolkit-Spotter' }
GTSpotterExceptionMock2 >> gtMockProcessorFor: aSpotterStep [
	<gtSearch>
	aSpotterStep listProcessor
		priority: 1;
		allCandidates: [ nil ];
		" Exception while collecting candidates "
			itemName: [ :item | item asString ];
		filter: GTFilterSubstring
]
