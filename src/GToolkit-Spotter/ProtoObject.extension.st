Extension { #name : #ProtoObject }

{ #category : #'*GToolkit-Spotter' }
ProtoObject >> gtSpotterActDefaultFrom: aSpotterElement [
	"override me to implement a default spotter action"
]

{ #category : #'*GToolkit-Spotter' }
ProtoObject >> gtSpotterSearchesInContext: aSpotterContext [
	<return: #TAsyncStream of: #GtSpotterSearch>

	^ GtSpotterUnorderedSearchesStream forOriginObject: self context: aSpotterContext
]
