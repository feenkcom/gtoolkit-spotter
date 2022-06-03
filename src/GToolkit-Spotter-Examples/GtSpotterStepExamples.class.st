Class {
	#name : #GtSpotterStepExamples,
	#superclass : #Object,
	#category : 'GToolkit-Spotter-Examples'
}

{ #category : #'step - examples' }
GtSpotterStepExamples >> defaultStep [
	<gtExample>
	| aStep |

	aStep := self emptyStep.
	aStep origin: GtWorldSpotterSearchStart new.
	self assert: aStep processors notEmpty.
	^ aStep
]

{ #category : #'step - examples' }
GtSpotterStepExamples >> emptyQueryOnStepWithProcessors [
	<gtExample>
	| aStep |
	
	aStep := self stepWithProcessors.
	aStep process: ''.
	
	^ aStep
]

{ #category : #'accessing-defaults' }
GtSpotterStepExamples >> emptyStep [
	<gtExample>
	| aStep |
	
	aStep := GtSpotterStep new.
	aStep asyncTask: GtSpotterSyncTask new.
	
	^ aStep
]

{ #category : #'step - examples' }
GtSpotterStepExamples >> stepWithProcessors [
	<gtExample>
	| aStep theProcessors |

	aStep := self emptyStep.
	aStep origin: GtSpotterStartSample new.

	theProcessors := aStep processors.

	^ aStep
]
