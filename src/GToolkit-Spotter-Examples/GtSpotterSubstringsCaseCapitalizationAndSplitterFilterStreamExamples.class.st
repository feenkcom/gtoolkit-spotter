Class {
	#name : #GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples,
	#superclass : #GtSpotterCustomSubstringsFilterStreamExamples,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #utils }
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> configureSpotterFilter: aSpotterFilter [
	aSpotterFilter
		withCapitalizationSplitter;
		beCaseSensitiveByCapitalization.
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> testMatchBeginningOfWord_capitalizedQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'Str' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> testMatchBeginningOfWord_lowercaseQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'str' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> testMatchBeginningOfWord_upperCaseQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'STR' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> testMatchBetweenTwoWords_queryWithOneMiddleUppercaseCharacter [
	<gtExample>
	
	self 
		assertQuerySearches: #('ingOn' 'ing On')
		in: #('StringOne' 'Stringone' 'AnotherTwo' ) 
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> testMatchBetweenTwoWords_queryWithOnlyLowercaseCharacters [
	<gtExample>
	
	self 
		assertQuerySearch: 'ingon' 
		in: #('StringOne' 'Stringone' 'StringTwoOn' ) 
		equals: #('StringOne' 'Stringone')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> testMatchBetweenTwoWords_queryWithTwoLowercaseWords [
	<gtExample>
	
	self 
		assertQuerySearch: 'ing on'
		in: #('StringOne' 'Stringone' 'StringTwoOn' 'NoMatch') 
		equals: #('StringOne' 'Stringone' 'StringTwoOn')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> testMatchBetweenTwoWords_queryWithTwoUppercaseCharacters [
	<gtExample>
	
	self 
		assertQuerySearches: #('IngOn' 'Ing On')
		in: #('StringOne' 'Stringone' 'StringTwoOn' ) 
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> testMatchEndOfWord_capitalizedQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'Ing' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> testMatchEndOfWord_lowercaseQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'ing' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> testMatchInsideWord_capitalizedQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'Tri' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> testMatchInsideWord_lowercaseQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'tri' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #('StringOne')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> testMatchInsideWord_uppercaseQuery [
	<gtExample>
	
	self 
		assertQuerySearch: 'TRI' 
		in: #('StringOne' 'AnotherTwo' ) 
		equals: #()
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> testMatchWithDigit_queryOneDigitOneLetterInTwoWords [
	<gtExample>
	
	self 
		assertQuerySearches: #('1o' '1O')
		in: #('String21One' 'Ano1therTwo' ) 
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
GtSpotterSubstringsCaseCapitalizationAndSplitterFilterStreamExamples >> testMatchWithDigit_queryOnlyOneDigit [
	<gtExample>
	
	self 
		assertQuerySearches: #('1' '2')
		in: #('String21One' 'AnotherTwo' ) 
		equals: #('String21One')
]
