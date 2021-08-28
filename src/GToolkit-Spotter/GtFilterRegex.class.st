Class {
	#name : 'GtFilterRegex',
	#superclass : 'GtUnorderedFilter',
	#instVars : [
		'regex'
	],
	#category : 'GToolkit-Spotter-Filters'
}

{ #category : 'private' }
GtFilterRegex >> applyFilterInContext: aSpotterContext error: exception [
	super applyFilterInContext: aSpotterContext error: exception.
	^ (GtFilterSubstrings new
		caseSensitive: self caseSensitive;
		yourself) value: aSpotterContext
]

{ #category : 'private' }
GtFilterRegex >> isMatchedItem: anItem [
	^ self regex matches: (self itemFilterNameFor: anItem)
]

{ #category : 'private' }
GtFilterRegex >> prepareFilterInContext: aSpotterContext [
	super prepareFilterInContext: aSpotterContext.
	
	self regex: (caseSensitive " performance optimization "
		ifTrue: [ self query asRegex ] 
		ifFalse: [ self query asRegexIgnoringCase ])
]

{ #category : 'accessing' }
GtFilterRegex >> regex [
	^ regex
]

{ #category : 'accessing' }
GtFilterRegex >> regex: anObject [
	regex := anObject
]
