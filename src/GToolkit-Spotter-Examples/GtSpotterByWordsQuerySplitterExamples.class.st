Class {
	#name : #GtSpotterByWordsQuerySplitterExamples,
	#superclass : #GtSpotterByWordsQuerySplitterBasicExamples,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #utils }
GtSpotterByWordsQuerySplitterExamples >> createQuerySplitter [
	^ GtSpotterByWordsQuerySplitter new
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithAllBinarySelectorCharacters [
	<gtExample>

	self assertSplitOf: '+-/\*~<>=@,%|&?!·÷±×' equals: #()
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithColonCharacter_multipleWithNoSpace [
	<gtExample>
	
	self assertSplitOf: 'print:on:' equals: #('print' 'on').
	self assertSplitOf: 'print:on:for:' equals: #('print' 'on' 'for')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithColonCharacter_multipleWithSpaces [
	<gtExample>
	
	self assertSplitOf: 'print: on:' equals: #('print' 'on').
	self assertSplitOf: 'Print: On:' equals: #('Print' 'On').
	self assertSplitOf: 'print: On:' equals: #('print' 'On')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithColonCharacter_singleAtEnd [
	<gtExample>
	
	self assertSplitOf: 'printOn:' equals: #('print' 'On').
	self assertSplitOf: 'printon:' equals: #('printon')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithColonCharacter_startWithColon_onlyLowercase [
	<gtExample>
	
	self assertSplitOf: ':a' equals: #('a').
	self assertSplitOf: '::a' equals: #('a').
	self assertSplitOf: ':a ::b :::c' equals: #('a' 'b' 'c').
	self assertSplitOf: ':a::b:::c' equals: #('a' 'b' 'c').
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithColonCharacter_startWithColon_withUppercase [
	<gtExample>
	
	self assertSplitOf: ':A' equals: #('A').
	self assertSplitOf: '::A' equals: #('A').
	self assertSplitOf: ':A ::B :::C' equals: #('A' 'B' 'C').
	self assertSplitOf: ':A::B:::C' equals: #('A' 'B' 'C').
	
	self assertSplitOf: ':A ::b :::C' equals: #('A' 'b' 'C').
	self assertSplitOf: ':A::b:::C' equals: #('A' 'b' 'C').
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithNonDigitCharacters [
	<gtExample>
	
	self
		assertSplitOf: 'One***Two---Three!@Four'
		equals: #('One' 'Two' 'Three' 'Four')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithUnderscoreSeparator [
	<gtExample>

	self assertSplitOf: 'one_two' equals: #('one' 'two')
]
