Class {
	#name : #GtSpotterStartWithWrongTitle,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : #examples }
GtSpotterStartWithWrongTitle >> gtSearchWithNilItemsFor: aSearch [
	" Exception while collecting candidates "
	<gtSearch>

	^ aSearch list
		title: nil;
		priority: 1;
		items: [ #(1 2 3) ];
		itemName: [ :item | item asString ];
		filterBySubstring
]
