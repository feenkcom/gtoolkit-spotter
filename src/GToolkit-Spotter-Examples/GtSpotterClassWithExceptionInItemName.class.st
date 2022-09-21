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
		items: [ #(1 2 3) ];
		itemName: [ :item | item / 0 ];
		filterBySubstring	" Exception while serializing candidates "
]
