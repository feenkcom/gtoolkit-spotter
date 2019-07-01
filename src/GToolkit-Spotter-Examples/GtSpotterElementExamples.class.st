Class {
	#name : #GtSpotterElementExamples,
	#superclass : #GtSpotterExamples,
	#category : #'GToolkit-Spotter-Examples'
}

{ #category : #examples }
GtSpotterElementExamples >> elementOnDefaultSpotter [
	<gtExample>
	| aSpotterElement aSpotterModel |

	aSpotterElement := self emptyElement.
	aSpotterModel := self defaultSpotter.

	aSpotterElement spotterModel: aSpotterModel.

	^ aSpotterElement
]

{ #category : #examples }
GtSpotterElementExamples >> elementOnDefaultSpotterInBorderlessWindow [
	<script: 'self new elementOnDefaultSpotterInBorderlessWindow'>
	| aSpotterElement aSpace |
	
	aSpotterElement := self elementOnDefaultSpotter.
	
	aSpace := BlSpace new.
	aSpace root: aSpotterElement.
	aSpace borderless: true.
	aSpace show
]

{ #category : #examples }
GtSpotterElementExamples >> elementOnSpotterWithOneStep [
	<gtExample>
	| aSpotterElement aSpotterModel |
	
	aSpotterElement := self emptyElement.
	aSpotterModel := self spotterWithOneStep.
	
	aSpotterElement spotterModel: aSpotterModel.
	
	^ aSpotterElement
]

{ #category : #examples }
GtSpotterElementExamples >> elementOnSpotterWithTwoSteps [
	<gtExample>
	| aSpotterElement aSpotterModel |
	
	aSpotterElement := self emptyElement.
	aSpotterModel := self spotterWithTwoSteps.
	
	aSpotterElement spotterModel: aSpotterModel.
	
	^ aSpotterElement
]

{ #category : #examples }
GtSpotterElementExamples >> emptyElement [
	<gtExample>
	
	^ GtSpotterElement new
]
