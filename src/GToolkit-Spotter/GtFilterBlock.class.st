Class {
	#name : 'GtFilterBlock',
	#superclass : 'GtUnorderedFilter',
	#instVars : [
		'matcher'
	],
	#category : 'GToolkit-Spotter-Filters'
}

{ #category : 'private' }
GtFilterBlock >> isMatchedItem: anItem [
	^ self matcher 
		ifNotNil: [ self matcher value: anItem value: self context ]
		ifNil: [ (self itemFilterNameFor: anItem) includesSubstring: query caseSensitive: caseSensitive ]
		
]

{ #category : 'accessing' }
GtFilterBlock >> matcher [
	^ matcher
]

{ #category : 'accessing' }
GtFilterBlock >> matcher: anObject [
	matcher := anObject
]
