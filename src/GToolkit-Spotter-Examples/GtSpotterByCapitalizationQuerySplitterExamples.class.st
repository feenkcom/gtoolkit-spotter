Class {
	#name : #GtSpotterByCapitalizationQuerySplitterExamples,
	#superclass : #GtSpotterQuerySplitterExamples,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #utils }
GtSpotterByCapitalizationQuerySplitterExamples >> createQuerySplitter [
	^ GtSpotterByCapitalizationQuerySplitter new
]

{ #category : #examples }
GtSpotterByCapitalizationQuerySplitterExamples >> splitQueryWithConsecutiveUpperCaseLettersAndOneLowercaseAtEnd [
	<gtExample>
	^ self 
		assertSplitOf: 'ABCDe'
		equals: #(ABCDe).
]

{ #category : #examples }
GtSpotterByCapitalizationQuerySplitterExamples >> splitQueryWithConsecutiveUpperCaseLettersAndOneLowercaseInTheMiddle [
	<gtExample>
	self 
		assertSplitOf: 'ABcDE'
		equals: #(ABc DE).
	self 
		assertSplitOf: 'ABcDEfGh'
		equals: #(ABc DEf Gh).
]

{ #category : #examples }
GtSpotterByCapitalizationQuerySplitterExamples >> splitQueryWithInitialLowercaseAndFollowingUppercase [
	<gtExample>
	^ self 
		assertSplitOf: 'oneTwo'
		equals: #(one Two).
]

{ #category : #examples }
GtSpotterByCapitalizationQuerySplitterExamples >> splitQueryWithMixedCapitalizationAndMultipleWords [
	<gtExample>
	^ self 
		assertSplitOf: 'one111 Two22Three AB'
		equals: #(one111 Two22 Three AB).
]

{ #category : #examples }
GtSpotterByCapitalizationQuerySplitterExamples >> splitQueryWithMultipleCapitalizedWords [
	<gtExample>
	self 
		assertSplitOf: 'OneTwo'
		equals: #(One Two).
	self 
		assertSplitOf: 'OneTwoThree'
		equals: #(One Two Three).
]

{ #category : #examples }
GtSpotterByCapitalizationQuerySplitterExamples >> splitQueryWithTwoCapitalizedWordsWithNumbers [
	<gtExample>
	self 
		assertSplitOf: 'One111Two22'
		equals: #(One111 Two22).
		
	self 
		assertSplitOf: 'one111Two22'
		equals: #(one111 Two22).
]
