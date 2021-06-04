"
I am the root class of the hierarchy of filter objects  that can be used by Spotter. 

The main entry point is the #value method that performs and returns the list of filtered items.
Subclasses should return the list of filtered elements in sorted order based on the filtering criteria.


"
Class {
	#name : #GtFilter,
	#superclass : #Object,
	#instVars : [
		'context',
		'filteredItems',
		'streamed'
	],
	#category : #'GToolkit-Spotter-Filters'
}

{ #category : #public }
GtFilter class >> gtFilter [
	^ self new
]

{ #category : #public }
GtFilter class >> gtListFilter [
	^ self new
]

{ #category : #'private-model' }
GtFilter >> addItem: anItem [
	self context streamed add: anItem.
	self context addItem: anItem
]

{ #category : #'private-model' }
GtFilter >> addItems: aCollection [
	self context streamed addAll: aCollection.
	self context addItems: aCollection
]

{ #category : #'private-model' }
GtFilter >> allItems [
	" WARNING: #allItems might be a list, block or iterator. we have to evaluate it in order to calculate the remaining/unstreamed items. #allItems are/were designed to be polymorphic to collections and streams. so this should be safe "
	| allItems |
	allItems := self processor allItemsIn: self context.
	^ self context isContinuing
		ifTrue: [ allItems value fasterDifferencePreservingOrder: self context streamed ]
		ifFalse: [ allItems ]
]

{ #category : #'private-model' }
GtFilter >> allItemsDo: aBlock [
	self allItems do: aBlock
]

{ #category : #private }
GtFilter >> applyFilter [
	^ self filteredItems
]

{ #category : #private }
GtFilter >> applyFilterInContext: aSpotterContext [
	self prepareFilterInContext: aSpotterContext.
	^ self applyFilter
]

{ #category : #private }
GtFilter >> applyFilterInContext: aSpotterContext error: anException [
	GtSpotterExceptionFilterSignal new
		filter: self;
		exception: anException freeze;
		emit.

	('[Spotter] Exception in filter <' , self class name , '>: '
		, anException asString) traceCr.
	^ self defaultFilteredItems
]

{ #category : #accessing }
GtFilter >> context [
	^ context
]

{ #category : #accessing }
GtFilter >> context: anObject [
	context := anObject
]

{ #category : #'accessing-defaults' }
GtFilter >> defaultFilteredItems [
	^ OrderedCollection new: 100 " not a limitation, just a reasonable start size "
]

{ #category : #'accessing-defaults' }
GtFilter >> defaultStreamed [
	^ true
]

{ #category : #'private-model' }
GtFilter >> exceptionHandler [
	self flag: 'Bloc -> overrides doesNotUnderstand discarding the current exception context'.
	^ GtCurrentSpotterExceptionHandler value ifNil: [ self context exceptionHandler ]
]

{ #category : #accessing }
GtFilter >> filteredItems [
	^ filteredItems
]

{ #category : #accessing }
GtFilter >> filteredItems: aCollection [
	filteredItems := aCollection
]

{ #category : #public }
GtFilter >> gtFilter [
	^ self
]

{ #category : #public }
GtFilter >> gtListFilter [
	^ self
]

{ #category : #testing }
GtFilter >> hasFilteredItems [
	^ self filteredItems isEmptyOrNil not
]

{ #category : #initializing }
GtFilter >> initialize [
	super initialize.
	
	self filteredItems: self defaultFilteredItems
]

{ #category : #'private-model' }
GtFilter >> itemFilterNameFor: anItem [
	"I return the string/text representation of an item used by the filter."
	
	^ self processor itemFilterNameFor: anItem
]

{ #category : #'private-model' }
GtFilter >> itemsLimit [
	^ self context itemsLimit
]

{ #category : #private }
GtFilter >> prepareFilterInContext: aSpotterContext [
	"I provide a hook for preprocessing the query once before performing a search."
	
	self context: aSpotterContext.
]

{ #category : #'private-model' }
GtFilter >> processor [
	^ self context processor
]

{ #category : #'private-model' }
GtFilter >> step [
	^ self context step
]

{ #category : #accessing }
GtFilter >> streamed [
	^ streamed ifNil: [ streamed := self defaultStreamed ]
]

{ #category : #accessing }
GtFilter >> streamed: anObject [
	streamed := anObject
]

{ #category : #public }
GtFilter >> value: aSpotterContext [
	"I provide an entry point for performing a search that is 
	polymorphic with BlockClosure>>value:. I return the list of
	filtered items."
	
	^ [ [ self applyFilterInContext: aSpotterContext ]
		on: Error
		do: [ :exception | 
			self exceptionHandler 
				handleException: exception 
				do: [ self applyFilterInContext: aSpotterContext error: exception ] ] ] 
		ensure: [ context := nil " release the context after search is completed " ] 
]
