Extension { #name : #GTSpotterExceptionMock4 }

{ #category : #'*GToolkit-Spotter' }
GTSpotterExceptionMock4 >> gtMockProcessorFor: aSpotterStep [
	<gtSearch>
	aSpotterStep listProcessor
		priority: 1;
		allCandidates: [ #(1 2 3) ];
		itemName: [ :item | item asString ];
		filter: GTSpotterExceptionMock4Filter	" Exception while filtering "
]
