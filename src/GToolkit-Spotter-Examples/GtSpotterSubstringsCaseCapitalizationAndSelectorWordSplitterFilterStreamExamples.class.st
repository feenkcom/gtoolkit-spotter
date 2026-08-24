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
GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples >> testMatchAcronymKeywordAndCamelCase [
	<gtExample>

	self
		assertQuerySearch: 'URL:fromString:'
		in: #('URL:fromString:' 'URL:fromString:ifAbsent:' 'url:fromString:' 'URL:from:' 'URLFromString:')
		equals: #('URL:fromString:' 'URL:fromString:ifAbsent:')
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
GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples >> testMatchCompleteKeywordSelector [
	<gtExample>

	self
		assertQuerySearch: 'link:toAST:'
		in: #('link:toAST:' 'link:toAst:' 'linkToAST:' 'link:toAST:in:' 'link:to:' 'link:fromAST:')
		equals: #('link:toAST:' 'link:toAST:in:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples >> testMatchGtSpotterMethodsForSelector [
	<gtExample>

	self
		assertQuerySearch: 'gtSpotterMethodsFor:'
		in: #('gtSpotterMethodsFor' 'gtSpotterMethodsFor:' 'gtSpotterMethodsFor:in:' 'gtSpotterMethods' 'gtSpotterMethodFor:')
		equals: #('gtSpotterMethodsFor:' 'gtSpotterMethodsFor:in:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples >> testMatchKeywordSelectorStructure [
	<gtExample>

	self
		assertQuerySearch: 'at:put:'
		in: #('atput:' 'at:put:' 'at:put:ifAbsent:' 'at:putAll:' 'at:')
		equals: #('at:put:' 'at:put:ifAbsent:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples >> testMatchMultiKeywordSelector [
	<gtExample>

	self
		assertQuerySearch: 'at:putAll:'
		in: #('atputAll:' 'at:putAll:' 'at:putAll:ifAbsent:' 'at:put:ifAbsent:' 'at:putAll')
		equals: #('at:putAll:' 'at:putAll:ifAbsent:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples >> testMatchPartialKeywordSelector [
	<gtExample>

	self
		assertQuerySearch: 'link:to'
		in: #('link:toAST:' 'link:toAst:' 'linkToAST:' 'link:toAST:in:' 'link:to:' 'link:fromAST:')
		equals: #('link:toAST:' 'link:toAst:' 'link:toAST:in:' 'link:to:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples >> testMatchUnderscoreBearingSelector [
	<gtExample>

	self
		assertQuerySearch: 'copy_to:'
		in: #('copyto:' 'copy_to' 'copy_to:' 'copy_to:from:' 'copy:to:')
		equals: #('copy_to:' 'copy_to:from:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndSelectorWordSplitterFilterStreamExamples >> testMatch_queryNonLetterCharacters [
	<gtExample>

	self
		assertQuerySearches: #('Str!@#$One')
		in: #('String21One' 'AnotherTwo')
		equals: #()
]
