Class {
	#name : #GtSpotterByWordsQuerySplitterExamples,
	#superclass : #GtSpotterQuerySplitterExamples,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #utils }
GtSpotterByWordsQuerySplitterExamples >> createQuerySplitter [
	^ GtSpotterByWordsQuerySplitter new
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithConsecutiveUpperCaseLettersAndOneLowercaseAtEnd [
	<gtExample>
	<return: #OrderedCollection>
	^ self assertSplitOf: 'ABCDe' equals: #('ABCDe')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithConsecutiveUpperCaseLettersAndOneLowercaseInTheMiddle [
	<gtExample>
	<return: #GtSpotterByWordsQuerySplitterExamples>
	self assertSplitOf: 'ABcDE' equals: #('ABc' 'DE').
	self assertSplitOf: 'ABcDEfGh' equals: #('ABc' 'DEf' 'Gh')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithInitialLowercaseAndFollowingUppercase [
	<gtExample>
	<return: #OrderedCollection>
	^ self assertSplitOf: 'oneTwo' equals: #('one' 'Two')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithMixedCapitalizationAndMultipleWords [
	<gtExample>
	<return: #OrderedCollection>
	^ self
		assertSplitOf: 'one111 Two22Three AB'
		equals: #('one111' 'Two22' 'Three' 'AB')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithMultipleCapitalizedWords [
	<gtExample>
	<return: #GtSpotterByWordsQuerySplitterExamples>
	self assertSplitOf: 'OneTwo' equals: #('One' 'Two').
	self assertSplitOf: 'OneTwoThree' equals: #('One' 'Two' 'Three')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithNonDigitCharacters [
	<gtExample>
	<return: #GtSpotterByWordsQuerySplitterExamples>
	self
		assertSplitOf: 'One***Two---Three!@$Four'
		equals: #('One' 'Two' 'Three' 'Four')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithTwoCapitalizedWordsWithNumbers [
	<gtExample>
	<return: #GtSpotterByWordsQuerySplitterExamples>
	self assertSplitOf: 'One111Two22' equals: #('One111' 'Two22').

	self assertSplitOf: 'one111Two22' equals: #('one111' 'Two22')
]
