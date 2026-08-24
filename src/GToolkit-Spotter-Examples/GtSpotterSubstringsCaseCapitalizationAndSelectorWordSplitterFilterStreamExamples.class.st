Class {
	#name : #GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples,
	#superclass : #GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamBasicExamples,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #utils }
GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples >> configureSpotterFilter: aSpotterFilter [
	aSpotterFilter
		withSelectorWordsSplitter;
		beCaseSensitiveByCapitalization.
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples >> testMatchBeginningOfWord_oneWordContainingMultipleColons_multipleCapitalizations [
	<gtExample>
	
	self
		assertQuerySearch: 'copy:to:'
		in: #('cOpy:to:' 'CopyTo' 'Copy:to:' 'copy:To:for:')
		equals: #('cOpy:to:' 'Copy:to:' 'copy:To:for:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples >> testMatchBeginningOfWord_oneWordContainingMultipleColons_onlyLowercase [
	<gtExample>
	
	self
		assertQuerySearch: 'copy:to:'
		in: #('copy' 'copyto' 'copy:' 'copy:to:' 'copy:to:for:')
		equals: #('copy:to:' 'copy:to:for:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples >> testMatchBeginningOfWord_oneWordEndingWithColon_multipleCapitalizations [
	<gtExample>
	
	self
		assertQuerySearch: 'copy:'
		in: #('copy' 'Copy:' 'copy:' 'copy:To:')
		equals: #('Copy:' 'copy:' 'copy:To:').
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples >> testMatchBeginningOfWord_oneWordEndingWithColon_onlyLowercase [
	<gtExample>
	
	self
		assertQuerySearch: 'copy:'
		in: #('copy' 'copy:' 'copy:to:')
		equals: #('copy:' 'copy:to:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples >> testMatch_queryNonLetterCharacters [
	<gtExample>

	self
		assertQuerySearches: #('Str!@#$One')
		in: #('String21One' 'AnotherTwo')
		equals: #()
]
