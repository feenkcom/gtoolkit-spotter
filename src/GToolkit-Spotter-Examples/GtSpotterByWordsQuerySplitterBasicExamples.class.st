Class {
	#name : #GtSpotterByWordsQuerySplitterBasicExamples,
	#superclass : #GtSpotterQuerySplitterExamples,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #testing }
GtSpotterByWordsQuerySplitterBasicExamples class >> isAbstract [
	^ self name = #GtSpotterByWordsQuerySplitterBasicExamples
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterBasicExamples >> splitQueryWithConsecutiveMixedUpperCaseLettersOnly [
	<gtExample>

	self assertSplitOf: 'ABCD12EF45GH' equals: #('ABCD12' 'EF45' 'GH')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterBasicExamples >> splitQueryWithConsecutiveUpperCaseLettersAndOneLowercaseAtEnd [
	<gtExample>
	
	self assertSplitOf: 'ABCDe' equals: #('ABCDe')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterBasicExamples >> splitQueryWithConsecutiveUpperCaseLettersAndOneLowercaseInTheMiddle [
	<gtExample>
	self assertSplitOf: 'ABcDE' equals: #('ABc' 'DE').
	self assertSplitOf: 'ABcDEfGh' equals: #('ABc' 'DEf' 'Gh')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterBasicExamples >> splitQueryWithInitialLowercaseAndFollowingUppercase [
	<gtExample>
	
	self assertSplitOf: 'oneTwo' equals: #('one' 'Two')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterBasicExamples >> splitQueryWithMixedCapitalizationAndMultipleWords [
	<gtExample>
	
	self assertSplitOf: 'one111 Two22Three AB' equals: #('one111' 'Two22' 'Three' 'AB')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterBasicExamples >> splitQueryWithMultipleCapitalizedWords [
	<gtExample>
	
	self assertSplitOf: 'OneTwo' equals: #('One' 'Two').
	self assertSplitOf: 'OneTwoThree' equals: #('One' 'Two' 'Three')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterBasicExamples >> splitQueryWithNonDigitAndNonSelectorCharacters [
	<gtExample>
	
	self
		assertSplitOf: 'One[[Two]]Three#{}$Four'
		equals: #('One' 'Two' 'Three' 'Four')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterBasicExamples >> splitQueryWithTwoCapitalizedWordsWithNumbers [
	<gtExample>
	
	self assertSplitOf: 'One111Two22' equals: #('One111' 'Two22').
	self assertSplitOf: 'one111Two22' equals: #('one111' 'Two22')
]
