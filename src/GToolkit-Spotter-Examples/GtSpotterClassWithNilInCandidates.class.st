Class {
	#name : #GtSpotterClassWithNilInCandidates,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : #examples }
GtSpotterClassWithNilInCandidates >> gtMockProcessorFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 1;
		items: [ nil ];
		itemName: [ :item | item asString ];
		filterBySubstring	" Exception while collecting candidates "
]
