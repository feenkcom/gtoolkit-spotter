Class {
	#name : #GtSpotterStartWithExceptionInFilter,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : #examples }
GtSpotterStartWithExceptionInFilter >> gtMockProcessorFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 1;
		items: [ #(1 2 3) ];
		itemName: [ :item | item asString ];
		filter: GtSpotterFilterWithException	" Exception while filtering "
]
