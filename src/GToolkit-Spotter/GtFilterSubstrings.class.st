Class {
	#name : #GtFilterSubstrings,
	#superclass : #GtUnorderedFilter,
	#instVars : [
		'separators'
	],
	#category : #'GToolkit-Spotter-Filters'
}

{ #category : #'accessing-defaults' }
GtFilterSubstrings >> defaultSeparators [
	^ ' '
]

{ #category : #private }
GtFilterSubstrings >> isMatchedItem: anItem [
	| itemName |
	itemName := self itemFilterNameFor: anItem.
	^ query allSatisfy: [ :fragment | 
		itemName includesSubstring: fragment caseSensitive: self caseSensitive ]
]

{ #category : #private }
GtFilterSubstrings >> prepareFilterInContext: aSpotterContext [
	super prepareFilterInContext: aSpotterContext.
	
	separators ifNil: [  separators := self defaultSeparators  ]. " performance optimization "
	self query: (self query substrings: self separators) asSet asArray
]

{ #category : #accessing }
GtFilterSubstrings >> separators [
	^ separators
]

{ #category : #accessing }
GtFilterSubstrings >> separators: anObject [
	separators := anObject
]
