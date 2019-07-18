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
	| theProcessorCandidates |
	
	theProcessorCandidates := processorCandidates
		detect: [ :eachProcessorCandidates | eachProcessorCandidates processor == aGtSpotterCandidate processor ]
		ifFound: #yourself
		ifNone: [ processorCandidates add: (GtSpotterProcessorCandidates of: aGtSpotterCandidate processor) ].
		
	theProcessorCandidates add: aGtSpotterCandidate.
	self notifyCandidateAdded: aGtSpotterCandidate
]

{ #category : #accessing }
GtSpotterCandidates >> announcer [
	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #accessing }
GtSpotterCandidates >> at: anIndex [
	| currentIndex |	

	currentIndex := 0.

	self do: [ :eachCandidate |
		currentIndex := currentIndex + 1.
		currentIndex = anIndex
			ifTrue: [ ^ eachCandidate ] ].
		
	self error: ('{1} is out of bounds' format: { anIndex })
]

{ #category : #accessing }
GtSpotterCandidates >> children [
	^ processorCandidates
]

{ #category : #enumerating }
GtSpotterCandidates >> do: aBlock [ 
	"Evaluate aBlock with each of the receiver's elements as the argument."

	processorCandidates do: [ :eachProcessorCandidates | eachProcessorCandidates do: aBlock ]
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

{ #category : #accessing }
GtSpotterCandidates >> indexOf: aCandidate [
	| anIndex |
	
	anIndex := 0.
	self do: [ :eachCandidate |
		anIndex := anIndex + 1.
		eachCandidate == aCandidate
			ifTrue: [ ^ anIndex ] ].
	^ 0
]

{ #category : #initialization }
GtSpotterCandidates >> initialize [
	super initialize.
	
	processorCandidates := SortedCollection sortBlock: [ :a :b | a < b ]
]

{ #category : #notifying }
GtSpotterCandidates >> notifyAllCandidatesRemoved [
	self announcer announce: GtSpotterAllCandidatesRemoved new
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

	self shouldNotImplement
]

{ #category : #removing }
GtSpotterCandidates >> removeAllCandidates [
	processorCandidates removeAll.

	self notifyAllCandidatesRemoved
]

{ #category : #accessing }
GtSpotterCandidates >> size [
	^ self children inject: 0 into: [ :sum :each | sum + each size ]
]

{ #category : #accessing }
GtSpotterCandidates >> treeIndexOf: aCandidate [
	| anIndex |
	
	anIndex := 0.

	self children do: [ :eachProcessorCandidates |
		anIndex := anIndex + 1.		
		eachProcessorCandidates do: [ :eachCandidate |
			anIndex := anIndex + 1.		
			eachCandidate == aCandidate
				ifTrue: [ ^ anIndex ] ] ].

	^ 0
]
