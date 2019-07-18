"
I represent a collection of candidates for some Spotter processor
"
Class {
	#name : #GtSpotterProcessorCandidates,
	#superclass : #Collection,
	#instVars : [
		'processor',
		'candidates'
	],
	#category : #'GToolkit-Spotter-Model - Candidates'
}

{ #category : #'instance creation' }
GtSpotterProcessorCandidates class >> of: aGtSpotterProcessor [
	^ self basicNew initialize processor: aGtSpotterProcessor
]

{ #category : #comparing }
GtSpotterProcessorCandidates >> < otherProcessorCandidates [
	^ self processor < otherProcessorCandidates processor
]

{ #category : #adding }
GtSpotterProcessorCandidates >> add: newObject [ 
	"Include newObject as one of the receiver's elements. Answer newObject. 
	ArrayedCollections cannot respond to this message."

	candidates add: newObject
]

{ #category : #accessing }
GtSpotterProcessorCandidates >> children [
	^ candidates
]

{ #category : #copying }
GtSpotterProcessorCandidates >> copyEmpty [
	^ self species of: self processor
]

{ #category : #enumerating }
GtSpotterProcessorCandidates >> do: aBlock [ 
	"Evaluate aBlock with each of the receiver's elements as the argument."

	candidates do: aBlock
]

{ #category : #printing }
GtSpotterProcessorCandidates >> gtDisplayOn: aStream [
	self processor gtDisplayOn: aStream
]

{ #category : #printing }
GtSpotterProcessorCandidates >> gtDisplayText [
	^ self processor gtDisplayText
]

{ #category : #initialization }
GtSpotterProcessorCandidates >> initialize [
	super initialize.
	
	candidates := OrderedCollection new
]

{ #category : #accessing }
GtSpotterProcessorCandidates >> priority [
	^ self processor priority
]

{ #category : #accessing }
GtSpotterProcessorCandidates >> processor [
	<return: #GtSpotterProcessor>

	^ processor
]

{ #category : #accessing }
GtSpotterProcessorCandidates >> processor: aGtSpotterProcessor [
	processor := aGtSpotterProcessor
]

{ #category : #removing }
GtSpotterProcessorCandidates >> remove: oldObject ifAbsent: anExceptionBlock [ 
	"Remove oldObject from the receiver's elements. If several of the 
	elements are equal to oldObject, only one is removed. If no element is 
	equal to oldObject, answer the result of evaluating anExceptionBlock. 
	Otherwise, answer the argument, oldObject. ArrayedCollections cannot 
	respond to this message."

	candidates remove: oldObject ifAbsent: anExceptionBlock
]

{ #category : #removing }
GtSpotterProcessorCandidates >> removeAll [
	candidates removeAll
]
