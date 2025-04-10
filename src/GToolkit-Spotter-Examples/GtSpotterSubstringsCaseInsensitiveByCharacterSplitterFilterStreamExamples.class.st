Class {
	#name : #GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples,
	#superclass : #GtSpotterCustomSubstringsFilterStreamExamples,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #utils }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> configureSpotterFilter: aSpotterFilter [
	aSpotterFilter
		withCharacterSplitter;
		beCaseInsensitive.
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchBeginningOfWord_capitalizedQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'Str' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchBeginningOfWord_lowercaseQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'str' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchBeginningOfWord_upperCaseQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'STR' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchBetweenTwoWords_queryWithOneMiddleUppercaseCharacter [
	<gtExample>
	
	self 
		assertQuerySearch: 'ingOn' 
		in: #('StringOne' 'Stringone' 'AnotherTwo' ) 
		equals: #('StringOne' 'Stringone')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchBetweenTwoWords_queryWithOnlyLowercaseCharacters [
	<gtExample>
	
	self 
		assertQuerySearch: 'ingon' 
		in: #('StringOne' 'Stringone' 'StringTwoOn' 'NoMatch') 
		equals: #('StringOne' 'Stringone')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchBetweenTwoWords_queryWithTwoLowercaseWords [
	<gtExample>
	
	self 
		assertQuerySearch: 'ing on'
		in: #('StringOne' 'Stringone' 'StringTwoOn' 'NoMatch') 
		equals: #('StringOne' 'Stringone' 'StringTwoOn')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchBetweenTwoWords_queryWithTwoUppercaseCharacters [
	<gtExample>
	
	self 
		assertQuerySearch: 'IngOn'
		in: #('StringOne' 'Stringone' 'StringTwoOn' ) 
		equals: #('StringOne' 'Stringone')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchBetweenTwoWords_queryWithTwoUppercaseWords [
	<gtExample>
	
	self 
		assertQuerySearch: 'Ing On'
		in: #('StringOne' 'Stringone' 'StringTwoOn' 'NoMatch') 
		equals: #('StringOne' 'Stringone' 'StringTwoOn')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchEndOfWord_capitalizedQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'Ing' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchEndOfWord_lowercaseQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'ing' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchInsideWord_capitalizedQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'Tri' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchInsideWord_lowercaseQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'tri' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchInsideWord_uppercaseQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'TRI' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchWithDigit_queryOneDigitOneLetterInTwoWords [
	<gtExample>
	
	self
		assertQuerySearches: #('1o' '1O')
		in: #('String21One' 'Ano1therTwo' ) 
		equals: #('String21One').
	
	self 
		assertQuerySearch: '1O'
		in: #('String21One' 'NoMatch') 
		equals: #('String21One').
		
	self 
		assertQuerySearch: '1o'
		in: #('Ano1therO' 'String21One' 'NoMatch') 
		equals: #('String21One')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatchWithDigit_queryOnlyOneDigit [
	<gtExample>
	
	self 
		assertQuerySearches: #('1' '2')
		in: #('String21One' 'AnotherTwo' ) 
		equals: #('String21One')
]

{ #category : #examples }
GtSpotterSubstringsCaseInsensitiveByCharacterSplitterFilterStreamExamples >> testMatch_queryNonLetterCharacters [
	<gtExample>
	
	self 
		assertQuerySearches: #('Str!@#$One')
		in: #('String21One' 'AnotherTwo' ) 
		equals: #()
]
