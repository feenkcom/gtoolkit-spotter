Extension { #name : #ProtoObject }

{ #category : #'*GToolkit-Spotter' }
ProtoObject >> gtSpotterSearchesInContext: aSpotterContext [
	<return: #TAsyncStream of: #GtSpotterSearch>

	^ GtSpotterUnorderedSearchesStream forOriginObject: self context: aSpotterContext
]
