Class {
	#name : #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples,
	#superclass : #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #utils }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> configureSpotterFilter: aSpotterFilter [
	aSpotterFilter
		withWordsSplitter;
		beCaseSensitiveByCapitalization.
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchBeginningOfWord_oneWordContainingMultipleColons_multipleCapitalizations [
	<gtExample>
	
	self
		assertQuerySearch: 'copy:to:'
		in: #('cOpy:to:' 'CopyTo' 'Copy:to:' 'copy:To:for:')
		equals: #('cOpy:to:' 'CopyTo' 'Copy:to:' 'copy:To:for:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchBeginningOfWord_oneWordContainingMultipleColons_onlyLowercase [
	<gtExample>
	
	self
		assertQuerySearch: 'copy:to:'
		in: #('copy' 'copyto' 'copy:' 'copy:to:' 'copy:to:for:')
		equals: #('copyto' 'copy:to:' 'copy:to:for:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchBeginningOfWord_oneWordEndingWithColon_multipleCapitalizations [
	<gtExample>
	
	self
		assertQuerySearch: 'copy:'
		in: #('copy' 'Copy:' 'copy:' 'copy:To:')
		equals: #('copy' 'Copy:' 'copy:' 'copy:To:').
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchBeginningOfWord_oneWordEndingWithColon_onlyLowercase [
	<gtExample>
	
	self
		assertQuerySearch: 'copy:'
		in: #('copy' 'copy:' 'copy:to:')
		equals: #('copy' 'copy:' 'copy:to:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatch_queryNonLetterCharacters [
	<gtExample>

	self
		assertQuerySearches: #('Str!@#$One')
		in: #('String21One' 'AnotherTwo')
		equals: #('String21One')
]
