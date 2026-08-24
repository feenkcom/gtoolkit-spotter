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
GtSpotterByWordsQuerySplitterExamples >> splitQueryForGtSpotterMethodsFor [
	<gtExample>

	self assertSplitOf: 'gtSpotterMethodsFor:' equals: #('gt' 'Spotter' 'Methods' 'For')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithAcronymKeywordAndCamelCase [
	<gtExample>

	self assertSplitOf: 'URL:fromString:' equals: #('URL' 'from' 'String')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithAllBinarySelectorCharacters [
	<gtExample>

	self assertSplitOf: '+-/\*~<>=@,%|&?!·÷±×' equals: #()
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithBinaryCharactersInKeyword [
	<gtExample>

	self assertSplitOf: 'foo->bar:' equals: #('foo' 'bar')
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
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithDigitsAtKeywordBoundary [
	<gtExample>

	self
		assertSplitOf: 'foo:2bar:' equals: #('foo' '2bar');
		assertSplitOf: 'foo:2Bar:' equals: #('foo' '2' 'Bar')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithKeywordSelectorsSeparatedByCapitalization [
	<gtExample>

	self assertSplitOf: 'link:toAST:' equals: #('link' 'to' 'AST').
	self assertSplitOf: 'copyFrom:to:' equals: #('copy' 'From' 'to')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithKeywordsSeparatedByCapitalization [
	<gtExample>

	self assertSplitOf: 'at:Put:ifAbsent:' equals: #('at' 'Put' 'if' 'Absent')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithMultiKeywordSelector [
	<gtExample>

	self assertSplitOf: 'at:putAll:ifAbsent:' equals: #('at' 'put' 'All' 'if' 'Absent')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithNonDigitCharacters [
	<gtExample>
	
	self
		assertSplitOf: 'One***Two---Three!@Four'
		equals: #('One' 'Two' 'Three' 'Four')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithUnderscoreAndColonInKeyword [
	<gtExample>

	self assertSplitOf: 'foo_:bar:' equals: #('foo' 'bar')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithUnderscoreAndKeywordSeparators [
	<gtExample>

	self assertSplitOf: 'copy_to:From:' equals: #('copy' 'to' 'From')
]

{ #category : #examples }
GtSpotterByWordsQuerySplitterExamples >> splitQueryWithUnderscoreSeparator [
	<gtExample>

	self assertSplitOf: 'one_two' equals: #('one' 'two')
]
