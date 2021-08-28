Class {
	#name : 'GtSpotterClassWithNilInCandidates',
	#superclass : 'Object',
	#category : 'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : 'examples' }
GtSpotterClassWithNilInCandidates >> gtMockProcessorFor: aSpotterStep [
	<gtSearch>
	aSpotterStep listProcessor
		priority: 1;
		allCandidates: [ nil ];
		" Exception while collecting candidates "
			itemName: [ :item | item asString ];
		filter: GtFilterSubstring
]
