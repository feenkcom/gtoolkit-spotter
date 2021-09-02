Class {
	#name : 'GtSpotterClassWithExceptionInFilter',
	#superclass : 'Object',
	#category : 'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : 'examples' }
GtSpotterClassWithExceptionInFilter >> gtMockProcessorFor: aSpotterStep [
	<gtSearch>
	aSpotterStep listProcessor
		priority: 1;
		allCandidates: [ #(1 2 3) ];
		itemName: [ :item | item asString ];
		filter: GtSpotterFilterWithException	" Exception while filtering "
]
