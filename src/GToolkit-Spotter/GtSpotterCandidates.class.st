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
GtSpotterCandidates >> notifyCandidateAdded: aCandidate [
	self announcer announce: (GtSpotterCandidateAdded new candidateLink: aCandidate; category: aCandidate processor; yourself).
]
