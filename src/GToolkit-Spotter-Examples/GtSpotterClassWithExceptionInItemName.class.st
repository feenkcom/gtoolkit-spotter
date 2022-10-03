Class {
	#name : #GtSpotterClassWithExceptionInItemName,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : #examples }
GtSpotterClassWithExceptionInItemName >> gtMockProcessorFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 1;
		items: [ #((4 1) (3 1) (2 0) (1 1)) ];
		" Exception while serializing candidates "
		itemName: [ :item | item first / item second ];
		filterBySubstring
]
