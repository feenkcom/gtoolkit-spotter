Class {
	#name : 'GtSpotterIterator',
	#superclass : 'Object',
	#instVars : [
		'context',
		'items'
	],
	#category : 'GToolkit-Spotter-Iterators'
}

{ #category : 'accessing' }
GtSpotterIterator class >> gtIterator [
	^ self new
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> allSatisfy: aBlock [
	self do: [ :each | (aBlock value: each) ifFalse: [ ^ false ] ].
	^ true
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> anySatisfy: aBlock [
	self do: [ :each | (aBlock value: each) ifTrue: [ ^ true ] ].
	^ false
]

{ #category : 'mimic collection' }
GtSpotterIterator >> asArray [
	^ self items asArray
]

{ #category : 'mimic collection' }
GtSpotterIterator >> asOrderedCollection [
	^ self items copy " we must not expose the internal representation ! "
]

{ #category : 'mimic collection' }
GtSpotterIterator >> asSet [
	^ self items asSet
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> collect: aBlock [
	^ self collect: aBlock as: self defaultItemsClass
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> collect: aBlock as: aCollectionClass [
	| collection |
	collection := self newAs: aCollectionClass.
	self do: [ :each | 
		collection add: (aBlock value: each) ].
	^ collection
]

{ #category : 'accessing' }
GtSpotterIterator >> context [
	^ context
]

{ #category : 'accessing' }
GtSpotterIterator >> context: aContext [
	" we assume that if the context changes, so will the result of the iterator - so we reset the internal collection "
	context := aContext.
	self reset.
]

{ #category : 'public' }
GtSpotterIterator >> cull: aContext [
	self context: aContext
]

{ #category : 'accessing-defaults' }
GtSpotterIterator >> defaultItems [
	^ self defaultItemsClass new 
]

{ #category : 'accessing-defaults' }
GtSpotterIterator >> defaultItemsClass [
	^ OrderedCollection 
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> detect: aBlock [
	^ self detect: aBlock ifNone: [ NotFound signalFor: aBlock ]
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> detect: aBlock ifFound: aBlock2 ifNone: aBlock3 [
	self do: [ :each | aBlock value ifTrue: [ ^ aBlock2 value: each ] ].
	^ aBlock3 value
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> detect: aBlock ifNone: aBlock2 [
	^ self detect: aBlock ifFound: [ :each | each ] ifNone: aBlock2
]

{ #category : 'mimic enumerating' }
GtSpotterIterator >> do: aBlock [
	" the iterator must keep an internal collection of items being iterated. This guarantees that the iteration is not done multiple times in case somebody sends multiple subsequent messages like #size, #items or #first:. This will slightly decrease performance while iterating "
	items 
		ifNotNil: [ 
			items do: aBlock ]
		ifNil: [ 
			items := self defaultItems.
			self itemDo: [ :each | 
				items add: each.
				aBlock value: each ] ]
]

{ #category : 'mimic collection' }
GtSpotterIterator >> first: anInteger [
	^ self items copyFrom: 1 to: (self size min: (anInteger max: 0))
]

{ #category : 'public' }
GtSpotterIterator >> gtIterator [
	^ self
]

{ #category : 'testing' }
GtSpotterIterator >> hasDynamicItems [
	^ true
]

{ #category : 'mimic collection' }
GtSpotterIterator >> isEmpty [
	^ self items isEmpty
]

{ #category : 'mimic collection' }
GtSpotterIterator >> isEmptyOrNil [
	^ self items isEmptyOrNil
]

{ #category : 'private' }
GtSpotterIterator >> itemDo: aBlock [
	self subclassResponsibility
]

{ #category : 'private' }
GtSpotterIterator >> items [
	^ items ifNil: [ 
		items := self defaultItems.
		self itemDo: [ :each | 
			items add: each ] ]
]

{ #category : 'private' }
GtSpotterIterator >> items: anObject [
	items := anObject
]

{ #category : 'mimic collection' }
GtSpotterIterator >> last: anInteger [
	^ self items last: (self size min: (anInteger max: 0))
]

{ #category : 'private' }
GtSpotterIterator >> newAs: aCollectionClass [
	^ items 
		ifNil: [ aCollectionClass new ] 
		ifNotNil: [ aCollectionClass new: self size ]
]

{ #category : 'mimic collection' }
GtSpotterIterator >> notEmpty [
	^ self isEmpty not
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> reject: aBlock [
	^ self reject: aBlock as: self defaultItemsClass
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> reject: aBlock as: aCollectionClass [
	| collection |
	collection := self newAs: aCollectionClass.
	self do: [ :each | 
		(aBlock value: each) 
			ifFalse: [ collection add: each ] ].
	^ collection
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> reject: aBlock thenCollect: aBlock2 as: aCollectionClass [
	| collection |
	collection := self newAs: aCollectionClass.
	self reject: aBlock thenDo: [ :each | 
		collection add: (aBlock2 value: each) ].
	^ collection
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> reject: aBlock thenDo: aBlock2 [
	self do: [ :each | 
		(aBlock value: each) 
			ifFalse: [ aBlock2 value: each ] ]
]

{ #category : 'public' }
GtSpotterIterator >> reset [
	items := nil.
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> select: aBlock [
	^ self select: aBlock as: self defaultItemsClass
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> select: aBlock as: aCollectionClass [
	| collection |
	collection := self newAs: aCollectionClass.
	self do: [ :each | 
		(aBlock value: each) 
			ifTrue: [ collection add: each ] ].
	^ collection
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> select: aBlock thenCollect: aBlock2 [
	^ self select: aBlock thenCollect: aBlock2 as: self defaultItemsClass
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> select: aBlock thenCollect: aBlock2 as: aCollectionClass [
	| collection |
	collection := self newAs: aCollectionClass.
	self select: aBlock thenDo: [ :each | 
		collection add: (aBlock2 value: each) ].
	^ collection
]

{ #category : 'mimic various enumerating' }
GtSpotterIterator >> select: aBlock thenDo: aBlock2 [
	self do: [ :each | 
		(aBlock value: each) 
			ifTrue: [ aBlock2 value: each ] ]
]

{ #category : 'mimic collection' }
GtSpotterIterator >> size [
	^ self items size
]

{ #category : 'public' }
GtSpotterIterator >> value [
	^ self items
]

{ #category : 'public' }
GtSpotterIterator >> value: aContext [
	self context: aContext
]

{ #category : 'mimic enumerating' }
GtSpotterIterator >> withIndexDo: aBlock [
	| index |
	index := 0.
	self do: [ :each | aBlock cull: each cull: (index := index + 1) ]
]
