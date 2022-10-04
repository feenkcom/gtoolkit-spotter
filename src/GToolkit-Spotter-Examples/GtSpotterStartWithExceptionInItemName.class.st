Class {
	#name : #GtSpotterStartWithExceptionInItemName,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : #examples }
GtSpotterStartWithExceptionInItemName >> gtMockProcessorFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 1;
		items: [ #((4 1) (3 1) (2 0) (1 1)) ];
		" Exception while serializing candidates "
		itemName: [ :item | item first / item second ];
		filterBySubstring
]
