Class {
	#name : 'GtFilterStringMatch',
	#superclass : 'GtUnorderedFilter',
	#category : 'GToolkit-Spotter-Filters'
}

{ #category : 'private' }
GtFilterStringMatch >> isMatchedItem: anItem [
	^ query match: (self itemFilterNameFor: anItem)
]
