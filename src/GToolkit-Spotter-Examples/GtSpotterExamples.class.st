Class {
	#name : #GtSpotterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples'
}

{ #category : #'instance creation examples' }
GtSpotterExamples >> emptySpotter [
	<gtExample>
	| aSpotter |

	aSpotter := GtSpotter new.
	self assert: aSpotter steps isEmpty.
	self assert: aSpotter hasSteps not.
	self assert: aSpotter foundationOrigin == aSpotter.

	^ aSpotter
]

{ #category : #'instance creation examples' }
GtSpotterExamples >> spotterWithOneStep [
	<gtExample>
	| aSpotter aStep |
	
	aSpotter := self emptySpotter.
	aSpotter addStep: (aStep := aSpotter newStep).

	aStep candidates add: (GtSpotterCandidate new item: Object >> #hash; processor: #Implementers).
	aStep candidates add: (GtSpotterCandidate new item: Object >> #=; processor: #Implementers).
	aStep candidates add: (GtSpotterCandidate new item: Object >> #at:; processor: #Implementers).
	
	aStep candidates add: (GtSpotterCandidate new item: Object; processor: #Classes).
	aStep candidates add: (GtSpotterCandidate new item: Collection; processor: #Classes).
	aStep candidates add: (GtSpotterCandidate new item: Number; processor: #Classes).
	aStep candidates add: (GtSpotterCandidate new item: Boolean; processor: #Classes).
	
	aStep candidates add: (GtSpotterCandidate new item: nil; processor: #'Pseudo-Variables').
	aStep candidates add: (GtSpotterCandidate new item: true; processor: #'Pseudo-Variables').
	aStep candidates add: (GtSpotterCandidate new item: false; processor: #'Pseudo-Variables').

	^ aSpotter
]

{ #category : #'instance creation examples' }
GtSpotterExamples >> spotterWithTwoSteps [
	<gtExample>
	| aSpotter aStep |
	
	aSpotter := self spotterWithOneStep.
	aSpotter addStep: (aStep := aSpotter newStep).
	
	aStep candidates add: (GtSpotterCandidate new item: 'Second'; processor: Collection).

	^ aSpotter
]
