"
I provide the functionality for filtering items based on a query.

I return the list of all items that match the filter but my subclasses should only send to the processor the first  #itemsLimit items .


"
Class {
	#name : #GtStringFilter,
	#superclass : #GtFilter,
	#instVars : [
		'caseSensitive',
		'query'
	],
	#category : 'GToolkit-Spotter-Filters'
}

{ #category : #private }
GtStringFilter >> applyFilter [
	self hasQuery ifFalse: [ 
		self applyFilterWithoutQuery.
		^ self allItems. " return the unfiltered items (all) - used for divein (no filtering appied) "  ].
	self applyFilterWithQuery.
	^ self filteredItems " return the filtered items only "
]

{ #category : #private }
GtStringFilter >> applyFilterWithQuery [
	
]

{ #category : #private }
GtStringFilter >> applyFilterWithoutQuery [
	" WARNING: this is not a copy of GTNullFilter>>#applyFilterWithoutQuery !!! "
	self streamed 
		ifTrue: [
			" this will be more responsive (faster) for very large collections and/or expensive filters "
			| reducedItems |
			self filteredItems: (reducedItems := OrderedCollection new).
			self allItems withIndexDo: [ :each :index |
				index <= self itemsLimit ifTrue: [ 
					reducedItems add: each.
					self addItem: each ] ] ]
		ifFalse: [
			" this will be much much faster for small collections and/or very quick filters " 
			self filteredItems: (self allItems first: (self itemsLimit min: self allItems size)).
			self addItems: self filteredItems ]
]

{ #category : #accessing }
GtStringFilter >> caseSensitive [
	^ caseSensitive
]

{ #category : #accessing }
GtStringFilter >> caseSensitive: anObject [
	caseSensitive := anObject
]

{ #category : #'accessing-defaults' }
GtStringFilter >> defaultCaseSensitive [
	^ false
]

{ #category : #testing }
GtStringFilter >> hasQuery [
	^ self query isEmptyOrNil not
]

{ #category : #private }
GtStringFilter >> prepareFilterInContext: aSpotterContext [
	super prepareFilterInContext: aSpotterContext.
	
	caseSensitive ifNil: [ caseSensitive := self defaultCaseSensitive ]. " performance optimization "
	self query: (caseSensitive " performance optimization "
		ifTrue: [ self context textTrimmed ]
		ifFalse: [ self context textLowercase ])
]

{ #category : #accessing }
GtStringFilter >> query [
	^ query
]

{ #category : #accessing }
GtStringFilter >> query: anObject [
	query := anObject
]
