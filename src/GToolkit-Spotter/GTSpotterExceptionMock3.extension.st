Extension { #name : #GTSpotterExceptionMock3 }

{ #category : #'*GToolkit-Spotter' }
GTSpotterExceptionMock3 >> gtMockProcessorFor: aSpotterStep [
	<gtSearch>
	aSpotterStep listProcessor
		priority: 1;
		allCandidates: [ #(1 2 3) ];
		itemName: [ :item | item / 0 ];
		" Exception while serializing candidates "
			filter: GtFilterSubstring
]
