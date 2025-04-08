Class {
	#name : #GtSpotterSubstringsFilter,
	#superclass : #Object,
	#traits : 'TGtSpotterFilter',
	#classTraits : 'TGtSpotterFilter classTrait',
	#instVars : [
		'itemStringComputation',
		'querySplitter',
		'caseComparison'
	],
	#classVars : [
		'DEFAULT_CASE_COMPARISON',
		'DEFAULT_QUERY_SPLITTER'
	],
	#category : #'GToolkit-Spotter-Filters'
}

{ #category : #configuring }
GtSpotterSubstringsFilter class >> defaultCaseComparison [
	DEFAULT_CASE_COMPARISON ifNil: [
		DEFAULT_CASE_COMPARISON := GtSpotterCaseInsensitiveComparison new]
]

{ #category : #configuring }
GtSpotterSubstringsFilter class >> defaultCaseComparison: aCaseComparison [
	DEFAULT_CASE_COMPARISON := aCaseComparison
]

{ #category : #configuring }
GtSpotterSubstringsFilter class >> defaultQuerySplitter [
	DEFAULT_QUERY_SPLITTER ifNil: [
		DEFAULT_QUERY_SPLITTER := GtSpotterByCharacterQuerySplitter new]
]

{ #category : #configuring }
GtSpotterSubstringsFilter class >> defaultQuerySplitter: aQuerySplitter [
	DEFAULT_QUERY_SPLITTER := aQuerySplitter
]

{ #category : #evaluating }
GtSpotterSubstringsFilter >> applyInScope: aStream context: aSpotterContext [
	| filterStream |
	
	filterStream := GtSpotterSubstringsFilterStream
		forStream: aStream
		search: aSpotterContext searchQuery.
		
	self configureFilterStream: filterStream inContext: aSpotterContext.
			
	^ filterStream
]

{ #category : #configuration }
GtSpotterSubstringsFilter >> beCaseSensitive [
	caseComparison := GtSpotterCaseSensitiveComparison new
]

{ #category : #configuration }
GtSpotterSubstringsFilter >> beCaseSensitiveByCapitalization [
	caseComparison := GtSpotterCaseSensitiveByCapitalizationComparison new
]

{ #category : #accessing }
GtSpotterSubstringsFilter >> caseComparison: aCaseComparison [
	caseComparison := aCaseComparison
]

{ #category : #evaluating }
GtSpotterSubstringsFilter >> configureFilterStream: aFilterStream inContext: aSpotterContext [
	| searchWords |
	
	aFilterStream itemString: itemStringComputation.
	 
	searchWords := self 
		wordsFromQueryString: aSpotterContext searchQuery.
	aFilterStream searchWords: searchWords.

	caseComparison applyOnFilterStream: aFilterStream.
]

{ #category : #initialization }
GtSpotterSubstringsFilter >> initialize [
	super initialize.
	
	itemStringComputation := [ :anObject | anObject printString ].
	querySplitter := self class defaultQuerySplitter.
	caseComparison := self class defaultCaseComparison.
]

{ #category : #accessing }
GtSpotterSubstringsFilter >> itemString: aBlock [
	itemStringComputation := aBlock
]

{ #category : #accessing }
GtSpotterSubstringsFilter >> itemStringComputation [

	^ itemStringComputation
]

{ #category : #accessing }
GtSpotterSubstringsFilter >> querySplitter [
	^ querySplitter
]

{ #category : #accessing }
GtSpotterSubstringsFilter >> querySplitter: aQuerySplitter [
	querySplitter := aQuerySplitter
]

{ #category : #configuration }
GtSpotterSubstringsFilter >> withCapitalizationSplitter [
	querySplitter := GtSpotterByCapitalizationQuerySplitter new.
]

{ #category : #configuration }
GtSpotterSubstringsFilter >> withCharacterSplitter [
	querySplitter := GtSpotterByCharacterQuerySplitter new.
]

{ #category : #configuration }
GtSpotterSubstringsFilter >> withCharacterSplitterBy: aCollectionOfCharacters [
	querySplitter := GtSpotterByCharacterQuerySplitter new
		wordSeparators: aCollectionOfCharacters.
]

{ #category : #utils }
GtSpotterSubstringsFilter >> wordsFromQueryString: aQueryString [ 
	^ self querySplitter splitQueryString: aQueryString
]
