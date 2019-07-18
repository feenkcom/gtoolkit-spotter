Class {
	#name : #GtSpotterStepExamples,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples'
}

{ #category : #'accessing-defaults' }
GtSpotterStepExamples >> defaultStep [
	<gtExample>
	| aStep |
	
	aStep := GtSpotterStep new.
	aStep asyncTask: GtSpotterSyncTask new.
	
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

{ #category : #'step - examples' }
GtSpotterStepExamples >> stepWithProcessors [
	<gtExample>
	| aStep theProcessors |

	aStep := self defaultStep.
	aStep origin: GtSpotterStartExample new.

	theProcessors := aStep processors.

	^ aStep
]
