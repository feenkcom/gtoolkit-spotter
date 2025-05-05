Class {
	#name : #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples,
	#superclass : #GtSpotterCustomSubstringsFilterStreamExamples,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #utils }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> configureSpotterFilter: aSpotterFilter [
	aSpotterFilter
		withWordsSplitter;
		beCaseSensitiveByCapitalization.
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchBeginningOfWord_capitalizedQuery [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
	self
		assertQuerySearch: 'Str'
		in: #('StringOne' 'AnotherTwo')
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchBeginningOfWord_lowercaseQuery [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
	self
		assertQuerySearch: 'str'
		in: #('StringOne' 'AnotherTwo')
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchBeginningOfWord_upperCaseQuery [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
	self
		assertQuerySearch: 'STR'
		in: #('StringOne' 'AnotherTwo')
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchBetweenTwoWords_queryWithOneMiddleUppercaseCharacter [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
	self
		assertQuerySearches: #('ingOn' 'ing On')
		in: #('StringOne' 'Stringone' 'AnotherTwo')
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchBetweenTwoWords_queryWithOnlyLowercaseCharacters [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
	self
		assertQuerySearch: 'ingon'
		in: #('StringOne' 'Stringone' 'StringTwoOn')
		equals: #('StringOne' 'Stringone')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchBetweenTwoWords_queryWithTwoLowercaseWords [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
	self
		assertQuerySearch: 'ing on'
		in: #('StringOne' 'Stringone' 'StringTwoOn' 'NoMatch')
		equals: #('StringOne' 'Stringone' 'StringTwoOn')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchBetweenTwoWords_queryWithTwoUppercaseCharacters [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
	self
		assertQuerySearches: #('IngOn' 'Ing On')
		in: #('StringOne' 'Stringone' 'StringTwoOn')
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchEndOfWord_capitalizedQuery [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
	self
		assertQuerySearch: 'Ing'
		in: #('StringOne' 'AnotherTwo')
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchEndOfWord_lowercaseQuery [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
	self
		assertQuerySearch: 'ing'
		in: #('StringOne' 'AnotherTwo')
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchInsideWord_capitalizedQuery [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
	self
		assertQuerySearch: 'Tri'
		in: #('StringOne' 'AnotherTwo')
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchInsideWord_lowercaseQuery [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
	self
		assertQuerySearch: 'tri'
		in: #('StringOne' 'AnotherTwo')
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchInsideWord_uppercaseQuery [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
	self
		assertQuerySearch: 'TRI'
		in: #('StringOne' 'AnotherTwo')
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchWithDigit_queryOneDigitOneLetterInTwoWords [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
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
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchWithDigit_queryOnlyOneDigit [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
	self
		assertQuerySearches: #('1' '2')
		in: #('String21One' 'AnotherTwo')
		equals: #('String21One')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatch_queryNonLetterCharacters [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
	self
		assertQuerySearches: #('Str!@#$One')
		in: #('String21One' 'AnotherTwo')
		equals: #('String21One')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testPositionOfMatch_oneQueryWord [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
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
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testPositionOfMatch_twoQueryWord [
	<gtExample>
	<return: #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples>
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
