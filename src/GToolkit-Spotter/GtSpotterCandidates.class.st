Class {
	#name : #GtSpotterCandidates,
	#superclass : #Collection,
	#instVars : [
		'announcer',
		'processorCandidates'
	],
	#category : #'GToolkit-Spotter-Model - Candidates'
}

{ #category : #adding }
GtSpotterCandidates >> add: aGtSpotterCandidate [ 
	"Add a spotter candidate to a collection of all candidates"

	(processorCandidates
		at: aGtSpotterCandidate processor
		ifAbsentPut: [ GtSpotterProcessorCandidates of: aGtSpotterCandidate processor ])
			add: aGtSpotterCandidate.
	self notifyCandidateAdded: aGtSpotterCandidate
]

{ #category : #adding }
GtSpotterCandidates >> addProcessor: aProcessor [
	processorCandidates
		at: aProcessor
		ifAbsentPut: [ GtSpotterProcessorCandidates of: aProcessor ]
]

{ #category : #accessing }
GtSpotterCandidates >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GtSpotterCandidates >> children [
	^ processorCandidates values
]

{ #category : #enumerating }
GtSpotterCandidates >> do: aBlock [ 
	"Evaluate aBlock with each of the receiver's elements as the argument."

	processorCandidates
		valuesDo: [ :eachProcessorCandidates | eachProcessorCandidates do: aBlock ]
]

{ #category : #accessing }
GtSpotterCandidates >> first [
	"Returns the first spotter candidate out of all candidates"
	<return: #GtSpotterCandidate>
	
	self do: [ :aCandidate | ^ aCandidate ]
]

{ #category : #'gt-extension' }
GtSpotterCandidates >> gtCandidatesFor: aView [
	<gtView>

	^ aView tree
		title: 'Candidates';
		priority: 10;
		items: [ self children ];
		children: #children
]

{ #category : #initialization }
GtSpotterCandidates >> initialize [
	super initialize.
	
	processorCandidates := OrderedDictionary new
]

{ #category : #notifying }
GtSpotterCandidates >> notifyAllCandidatesRemoved [
	self announcer announce: GTSpotterAllCandidatesRemoved new
]

{ #category : #notifying }
GtSpotterCandidates >> notifyCandidateAdded: aCandidate [
	self announcer announce: (GtSpotterCandidateAdded new candidateLink: aCandidate; category: aCandidate processor; yourself).
]

{ #category : #notifying }
GtSpotterCandidates >> notifyCandidateRemoved: aCandidate [
	self announcer announce: (GtSpotterCandidateAdded new candidateLink: aCandidate; category: aCandidate processor; yourself).
]

{ #category : #notifying }
GtSpotterCandidates >> onAmountChanged: anInteger in: aProcessor [
	self
		assert: [ anInteger >= 0 ]
		description: [ 'Amount must be non-negative' ].
	
	"If amount is not positive there is no need to do anything"
	anInteger isZero
		ifTrue: [ ^ self ].

	self announcer announce: (GTSpotterCandidatesAmountChanged new amount: anInteger; category: aProcessor; yourself)
]

{ #category : #removing }
GtSpotterCandidates >> remove: aGtSpotterCandidate ifAbsent: anExceptionBlock [ 
	"Remove oldObject from the receiver's elements. If several of the 
	elements are equal to oldObject, only one is removed. If no element is 
	equal to oldObject, answer the result of evaluating anExceptionBlock. 
	Otherwise, answer the argument, oldObject. ArrayedCollections cannot 
	respond to this message."

	"Add a spotter candidate to a collection of all candidates"

	(processorCandidates
		at: aGtSpotterCandidate processor
		ifAbsent: anExceptionBlock)
			remove: aGtSpotterCandidate
			ifAbsent: anExceptionBlock.
	self notifyCandidateRemoved: aGtSpotterCandidate
]

{ #category : #removing }
GtSpotterCandidates >> removeAllCandidates [
	processorCandidates := OrderedDictionary new.
	self notifyAllCandidatesRemoved
]
