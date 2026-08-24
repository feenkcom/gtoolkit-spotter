Class {
	#name : #GtSpotterByCharacterQuerySplitterExamples,
	#superclass : #GtSpotterQuerySplitterExamples,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #utils }
GtSpotterByCharacterQuerySplitterExamples >> createQuerySplitter [
	^ GtSpotterByCharacterQuerySplitter new
]

{ #category : #examples }
GtSpotterByCharacterQuerySplitterExamples >> splitQueryWithAllBinarySelectorCharacters [
	<gtExample>

	self assertSplitOf: '+-/\*~<>=@,%|&?!·÷±×' equals: #('+-/\*~<>=@,%|&?!·÷±×')
]

{ #category : #examples }
GtSpotterByCharacterQuerySplitterExamples >> splitQueryWithConsecutiveMixedUpperCaseLettersOnly [
	<gtExample>

	self assertSplitOf: 'ABCD12EF45GH' equals: #('ABCD12EF45GH')
]

{ #category : #examples }
GtSpotterByCharacterQuerySplitterExamples >> splitQueryWithNonDigitAndNonSelectorCharacters [
	<gtExample>
	
	self
		assertSplitOf: 'One[[Two]]hree#{}$Four'
		equals: #('One[[Two]]hree#{}$Four')
]

{ #category : #examples }
GtSpotterByCharacterQuerySplitterExamples >> splitQueryWithNonDigitCharacters [
	<gtExample>
	<return: #GtSpotterByCharacterQuerySplitterExamples>
	self
		assertSplitOf: 'One***Two---Three!@Four'
		equals: #('One***Two---Three!@Four')
]

{ #category : #examples }
GtSpotterByCharacterQuerySplitterExamples >> splitQueryWithUnderscoreSeparator [
	<gtExample>

	self assertSplitOf: 'one_two' equals: #('one_two')
]
