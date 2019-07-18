Class {
	#name : #GtSpotterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples'
}

{ #category : #'instance creation examples' }
GtSpotterExamples >> defaultSpotter [
	<gtExample>
	| aSpotter |

	aSpotter := GtSpotter new.
	aSpotter beDebugging.
	self assert: aSpotter steps isEmpty not.
	self assert: aSpotter hasSteps.
	self assert: aSpotter foundationOrigin class = GtSpotterStart.
	self assert: aSpotter currentStep == aSpotter steps first.
	self assert: aSpotter text = ''.

	^ aSpotter
]

{ #category : #'instance creation' }
GtSpotterExamples >> processorWithName: aString [
	^ GtSpotterCandidatesListProcessor new title: aString
]

{ #category : #'instance creation examples' }
GtSpotterExamples >> spotterWithOneStep [
	<gtExample>
	| aSpotter aStep implementorsProcessor classesProcessor pseudoVariablesProcesspr |
	
	aSpotter := self defaultSpotter.
	aSpotter addStep: (aStep := aSpotter newStep).
	
	
	implementorsProcessor := self processorWithName: #Implementers.
	classesProcessor := self processorWithName: #Classes.
	pseudoVariablesProcesspr := self processorWithName: #'Pseudo-Variables'.

	aStep candidates add: (GtSpotterCandidate new item: Object >> #hash; processor: implementorsProcessor).
	aStep candidates add: (GtSpotterCandidate new item: Object >> #=; processor: implementorsProcessor).
	aStep candidates add: (GtSpotterCandidate new item: Object >> #at:; processor: implementorsProcessor).
	
	aStep candidates add: (GtSpotterCandidate new item: Object; processor: classesProcessor).
	aStep candidates add: (GtSpotterCandidate new item: Collection; processor: classesProcessor).
	aStep candidates add: (GtSpotterCandidate new item: Number; processor: classesProcessor).
	aStep candidates add: (GtSpotterCandidate new item: Boolean; processor: classesProcessor).
	
	aStep candidates add: (GtSpotterCandidate new item: nil; processor: pseudoVariablesProcesspr).
	aStep candidates add: (GtSpotterCandidate new item: true; processor: pseudoVariablesProcesspr).
	aStep candidates add: (GtSpotterCandidate new item: false; processor: pseudoVariablesProcesspr).

	^ aSpotter
]

{ #category : #'instance creation examples' }
GtSpotterExamples >> spotterWithTwoSteps [
	<gtExample>
	| aSpotter aStep collectionProcessor |
	
	aSpotter := self spotterWithOneStep.
	aSpotter addStep: (aStep := aSpotter newStep).
	
	collectionProcessor := self processorWithName: #Collection.
	
	aStep candidates add: (GtSpotterCandidate new item: 'Second'; processor: collectionProcessor).

	^ aSpotter
]
