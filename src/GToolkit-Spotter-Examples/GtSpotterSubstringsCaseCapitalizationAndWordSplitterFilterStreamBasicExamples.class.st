Class {
	#name : #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples,
	#superclass : #GtSpotterCustomSubstringsFilterStreamExamples,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #testing }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples class >> isAbstract [
	^ self name = #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchBeginningOfWord_capitalizedQuery [
	<gtExample>

	self
		assertQuerySearch: 'Str'
		in: #('StringOne' 'AnotherTwo')
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchBeginningOfWord_lowercaseQuery [
	<gtExample>

	self
		assertQuerySearch: 'str'
		in: #('StringOne' 'AnotherTwo')
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchBeginningOfWord_upperCaseQuery [
	<gtExample>

	self
		assertQuerySearch: 'STR'
		in: #('StringOne' 'AnotherTwo')
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchBetweenTwoWords_queryWithOneMiddleUppercaseCharacter [
	<gtExample>

	self
		assertQuerySearches: #('ingOn' 'ing On')
		in: #('StringOne' 'Stringone' 'AnotherTwo')
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchBetweenTwoWords_queryWithOnlyLowercaseCharacters [
	<gtExample>

	self
		assertQuerySearch: 'ingon'
		in: #('StringOne' 'Stringone' 'StringTwoOn')
		equals: #('StringOne' 'Stringone')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchBetweenTwoWords_queryWithTwoLowercaseWords [
	<gtExample>

	self
		assertQuerySearch: 'ing on'
		in: #('StringOne' 'Stringone' 'StringTwoOn' 'NoMatch')
		equals: #('StringOne' 'Stringone' 'StringTwoOn')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchBetweenTwoWords_queryWithTwoUppercaseCharacters [
	<gtExample>

	self
		assertQuerySearches: #('IngOn' 'Ing On')
		in: #('StringOne' 'Stringone' 'StringTwoOn')
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchBetweenTwoWords_queryWithTwoUppercaseWords [
	<gtExample>

	self
		assertQuerySearch: 'Ing On'
		in: #('StringOne' 'Stringone' 'StringTwoOn' 'NoMatch')
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchEndOfWord_capitalizedQuery [
	<gtExample>

	self
		assertQuerySearch: 'Ing'
		in: #('StringOne' 'AnotherTwo')
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchEndOfWord_lowercaseQuery [
	<gtExample>

	self
		assertQuerySearch: 'ing'
		in: #('StringOne' 'AnotherTwo')
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchInsideWord_capitalizedQuery [
	<gtExample>

	self
		assertQuerySearch: 'Tri'
		in: #('StringOne' 'AnotherTwo')
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchInsideWord_lowercaseQuery [
	<gtExample>

	self
		assertQuerySearch: 'tri'
		in: #('StringOne' 'AnotherTwo')
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchInsideWord_uppercaseQuery [
	<gtExample>

	self
		assertQuerySearch: 'TRI'
		in: #('StringOne' 'AnotherTwo')
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchWithDigit_queryOneDigitOneLetterInTwoWords [
	<gtExample>

	self
		assertQuerySearches: #('1o' '1O')
		in: #('String21One' 'Ano1therTwo')
		equals: #('String21One').

	self
		assertQuerySearch: '1O'
		in: #('Ano1therO' 'String21One' 'NoMatch')
		equals: #('Ano1therO' 'String21One').

	self
		assertQuerySearch: '1o'
		in: #('Ano1therO' 'String21One' 'NoMatch')
		equals: #('String21One')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatchWithDigit_queryOnlyOneDigit [
	<gtExample>

	self
		assertQuerySearches: #('1' '2')
		in: #('String21One' 'AnotherTwo')
		equals: #('String21One')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testMatch_queryNonLetterCharacters [
	<gtExample>

	self
		assertQuerySearches: #('Str!@#$One')
		in: #('String21One' 'AnotherTwo')
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testPositionOfMatch_oneQueryWord [
	<gtExample>

	| filterStream |
	filterStream := self
			createFilterWithQuerySearch: 'stringone'
			in: #('stringone' 'stringonetwo' 'twostringone') asAsyncStream.

	self assert: (filterStream searchSubstringIn: 'stringone') isExact.
	self assert: (filterStream searchSubstringIn: 'stringonet') isPrefix.
	self assert: (filterStream searchSubstringIn: 'twostringone') isMiddle.
	self
		assert: (filterStream searchSubstringIn: 'three') class
		equals: GtSpotterSubstringFilterNoMatch
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples >> testPositionOfMatch_twoQueryWord [
	<gtExample>

	| filterStream |
	filterStream := self
			createFilterWithQuerySearch: 'StringOne'
			in: #('StringOne' 'StringSomethingOne' 'StringOneTwo' 'TwoStringOne') asAsyncStream.

	self assert: (filterStream searchSubstringIn: 'StringOne') isExact.
	self assert: (filterStream searchSubstringIn: 'StringSomethingOne') isPrefix.
	self assert: (filterStream searchSubstringIn: 'StringOneTw') isPrefix.
	self assert: (filterStream searchSubstringIn: 'TwoStringOne') isMiddle.
	self
		assert: (filterStream searchSubstringIn: 'StringTwo') class
		equals: GtSpotterSubstringFilterNoMatch
]
