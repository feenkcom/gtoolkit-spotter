Class {
	#name : #GtSpotterClassWithExceptionInItemName,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : #examples }
GtSpotterClassWithExceptionInItemName >> gtMockProcessorFor: aSpotterStep [
	<gtSearch>
	aSpotterStep listProcessor
		priority: 1;
		allCandidates: [ #(1 2 3) ];
		itemName: [ :item | item / 0 ];
		" Exception while serializing candidates "
			filter: GtFilterSubstring
]
