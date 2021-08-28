Class {
	#name : 'GtFilterImplementor',
	#superclass : 'GtFilterSubstring',
	#category : 'GToolkit-Spotter-Filters'
}

{ #category : 'public' }
GtFilterImplementor class >> gtListFilter [
	^ GtFilterSubstring new
]

{ #category : 'private' }
GtFilterImplementor >> applyFilterWithQuery [ 
	super applyFilterWithQuery.
	self filteredItems: (self filteredItems reject: [:each | each isFromTrait]).
]

{ #category : 'public' }
GtFilterImplementor >> gtListFilter [
	^ GtFilterSubstring new
]

{ #category : 'private-model' }
GtFilterImplementor >> itemFilterNameFor: each [
	self flag: 'this filter wants to filter items by #selector (speed 10x), but dive-in-category wants to filter by #printString. Most filters in dive-in-category wants to filter by #printString, but not all. Others: files, topics, help, ... ?'.
	^ each selector
]
