Class {
	#name : #GtSpotterSubstringFilter,
	#superclass : #Object,
	#traits : 'TGtSpotterFilter',
	#classTraits : 'TGtSpotterFilter classTrait',
	#instVars : [
		'itemStringComputation'
	],
	#category : #'GToolkit-Spotter-Filters'
}

{ #category : #evaluating }
GtSpotterSubstringFilter >> applyInScope: aStream context: aSpotterContext [
	^ (GtSpotterSubstringFilterStream
		forStream: aStream
		search: aSpotterContext searchQuery)
			itemString: itemStringComputation
]

{ #category : #initialization }
GtSpotterSubstringFilter >> initialize [
	super initialize.
	
	itemStringComputation := [ :anObject | anObject printString ]
]

{ #category : #accessing }
GtSpotterSubstringFilter >> itemString: aBlock [
	itemStringComputation := aBlock
]

{ #category : #accessing }
GtSpotterSubstringFilter >> itemStringComputation [

	^ itemStringComputation
]
