Class {
	#name : 'GtSpotterPagerExamples',
	#superclass : 'GtSpotterExamples',
	#category : 'GToolkit-Spotter-Examples'
}

{ #category : 'as yet unclassified' }
GtSpotterPagerExamples >> emptyPager [
	<gtExample>
	| aPager |

	aPager := GtSpotterPager new.
	^ aPager
]

{ #category : 'as yet unclassified' }
GtSpotterPagerExamples >> pagerOnSpotterStep [
	<gtExample>
	| aSpotter aPager |
	
	aSpotter := self spotterWithOneStep.
	aPager := self emptyPager.
	
	aPager spotterModel: aSpotter.
	
	^ aPager
]

{ #category : 'as yet unclassified' }
GtSpotterPagerExamples >> pagerOnSpotterWithTwoSteps [
	<gtExample>
	| aSpotter aPager |
	
	aSpotter := self spotterWithTwoSteps.
	aPager := self emptyPager.
	
	aPager spotterModel: aSpotter.
	
	^ aPager
]
