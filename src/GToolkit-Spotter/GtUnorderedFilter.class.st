Class {
	#name : #GtUnorderedFilter,
	#superclass : #GtStringFilter,
	#category : #'GToolkit-Spotter-Filters'
}

{ #category : #private }
GtUnorderedFilter >> applyFilterWithQuery [
	| unorderedMatchedItems |
	unorderedMatchedItems := OrderedCollection new.
	self allItemsDo: [ :each | 
		(self isMatchedItem: each)
				ifTrue: [
					unorderedMatchedItems add: each.
					unorderedMatchedItems size > self itemsLimit 
						ifFalse: [ self addItem: each ] ] ].
	self filteredItems: unorderedMatchedItems
]

{ #category : #private }
GtUnorderedFilter >> isMatchedItem: anItem [
	^ false
]
