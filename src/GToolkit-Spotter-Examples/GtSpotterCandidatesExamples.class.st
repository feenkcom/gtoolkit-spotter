Class {
	#name : #GtSpotterCandidatesExamples,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples'
}

{ #category : #requirements }
GtSpotterCandidatesExamples >> empty [
	<gtExample>
	
	^ GtSpotterCandidates new
]

{ #category : #'as yet unclassified' }
GtSpotterCandidatesExamples >> processorA_item_1 [
	<gtExample>
	| theCandidates |
	
	theCandidates := self empty.
	theCandidates add: (GtSpotterCandidate new item: 1; processor: #A).
	
	^ theCandidates
]

{ #category : #'as yet unclassified' }
GtSpotterCandidatesExamples >> processorA_item_2 [
	<gtExample>
	| theCandidates |
	
	theCandidates := self processorA_item_1.
	theCandidates add: (GtSpotterCandidate new item: 2; processor: #A).
	
	^ theCandidates
]

{ #category : #'as yet unclassified' }
GtSpotterCandidatesExamples >> processorB_item_1 [
	<gtExample>
	| theCandidates |
	
	theCandidates := self processorA_item_2.
	theCandidates add: (GtSpotterCandidate new item: 1; processor: #B).
	
	^ theCandidates
]
