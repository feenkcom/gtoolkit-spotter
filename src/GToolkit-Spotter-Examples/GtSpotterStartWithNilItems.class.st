Class {
	#name : #GtSpotterStartWithNilItems,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : #examples }
GtSpotterStartWithNilItems >> gtSearchWithNilItemsFor: aSearch [
	" Exception while collecting candidates "
	<gtSearch>

	^ aSearch list
		title: 'Nil items';
		priority: 1;
		items: [ nil ];
		itemName: [ :item | item asString ];
		filterBySubstring
]
