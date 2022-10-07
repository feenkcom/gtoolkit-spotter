Extension { #name : #ProtoObject }

{ #category : #'*GToolkit-Spotter' }
ProtoObject >> gtSpotterSearchesInContext: aSpotterContext [
	<return: #TAsyncStream of: #GtSpotterSearch>

	^ GtSpotterOrderedSearchesStream forOriginObject: self context: aSpotterContext
]
