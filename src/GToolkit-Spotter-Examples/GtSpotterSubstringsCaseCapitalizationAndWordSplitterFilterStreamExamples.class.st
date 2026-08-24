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
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchAcronymKeywordAndCamelCase [
	<gtExample>

	self
		assertQuerySearch: 'URL:fromString:'
		in: #('URL:fromString:' 'URL:fromString:ifAbsent:' 'url:fromString:' 'URL:from:' 'URLFromString:')
		equals: #('URL:fromString:' 'URL:fromString:ifAbsent:' 'URLFromString:')
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
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchCompleteKeywordSelector [
	<gtExample>

	self
		assertQuerySearch: 'link:toAST:'
		in: #('link:toAST:' 'link:toAst:' 'linkToAST:' 'link:toAST:in:' 'link:to:' 'link:fromAST:')
		equals: #('link:toAST:' 'linkToAST:' 'link:toAST:in:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchGtSpotterMethodsForSelector [
	<gtExample>

	self
		assertQuerySearch: 'gtSpotterMethodsFor:'
		in: #('gtSpotterMethodsFor' 'gtSpotterMethodsFor:' 'gtSpotterMethodsFor:in:' 'gtSpotterMethods' 'gtSpotterMethodFor:')
		equals: #('gtSpotterMethodsFor' 'gtSpotterMethodsFor:' 'gtSpotterMethodsFor:in:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchKeywordSelectorStructure [
	<gtExample>

	self
		assertQuerySearch: 'at:put:'
		in: #('atput:' 'at:put:' 'at:put:ifAbsent:' 'at:putAll:' 'at:')
		equals: #('atput:' 'at:put:' 'at:put:ifAbsent:' 'at:putAll:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchMultiKeywordSelector [
	<gtExample>

	self
		assertQuerySearch: 'at:putAll:'
		in: #('atputAll:' 'at:putAll:' 'at:putAll:ifAbsent:' 'at:put:ifAbsent:' 'at:putAll')
		equals: #('atputAll:' 'at:putAll:' 'at:putAll:ifAbsent:' 'at:putAll')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchPartialKeywordSelector [
	<gtExample>

	self
		assertQuerySearch: 'link:to'
		in: #('link:toAST:' 'link:toAst:' 'linkToAST:' 'link:toAST:in:' 'link:to:' 'link:fromAST:')
		equals: #('link:toAST:' 'link:toAst:' 'linkToAST:' 'link:toAST:in:' 'link:to:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatchUnderscoreBearingSelector [
	<gtExample>

	self
		assertQuerySearch: 'copy_to:'
		in: #('copyto:' 'copy_to' 'copy_to:' 'copy_to:from:' 'copy:to:')
		equals: #('copyto:' 'copy_to' 'copy_to:' 'copy_to:from:' 'copy:to:')
]

{ #category : #examples }
GtSpotterSubstringsCaseCapitalizationAndWordSplitterFilterStreamExamples >> testMatch_queryNonLetterCharacters [
	<gtExample>

	self
		assertQuerySearches: #('Str!@#$One')
		in: #('String21One' 'AnotherTwo')
		equals: #('String21One')
]
