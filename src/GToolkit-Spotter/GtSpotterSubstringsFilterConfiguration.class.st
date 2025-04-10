Class {
	#name : #GtSpotterSubstringsFilterConfiguration,
	#superclass : #GtSpotterFilterConfiguration,
	#instVars : [
		'querySplitter',
		'caseComparison'
	],
	#classVars : [
		'DEFAULT_CASE_COMPARISON',
		'DEFAULT_QUERY_SPLITTER'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #conf }
GtSpotterSubstringsFilterConfiguration class >> defaultCaseComparison [
	^ DEFAULT_CASE_COMPARISON ifNil: [
		DEFAULT_CASE_COMPARISON := GtSpotterCaseInsensitiveComparison new]
]

{ #category : #conf }
GtSpotterSubstringsFilterConfiguration class >> defaultCaseComparison: aCaseComparison [
	DEFAULT_CASE_COMPARISON := aCaseComparison
]

{ #category : #conf }
GtSpotterSubstringsFilterConfiguration class >> defaultQuerySplitter [
	^ DEFAULT_QUERY_SPLITTER ifNil: [
		DEFAULT_QUERY_SPLITTER := GtSpotterByCharacterQuerySplitter new]
]

{ #category : #conf }
GtSpotterSubstringsFilterConfiguration class >> defaultQuerySplitter: aQuerySplitter [
	DEFAULT_QUERY_SPLITTER := aQuerySplitter
]

{ #category : #api }
GtSpotterSubstringsFilterConfiguration >> applyOnFilter: aSearchFilter [
	caseComparison ifNotNil: [ :aCaseComparison |
		aSearchFilter caseComparison: aCaseComparison ].
	querySplitter ifNotNil: [ :aQuerySplitter |
		aSearchFilter querySplitter: aQuerySplitter ]
]

{ #category : #configuration }
GtSpotterSubstringsFilterConfiguration >> beCaseInsensitive [
	caseComparison := GtSpotterCaseInsensitiveComparison new
]

{ #category : #configuration }
GtSpotterSubstringsFilterConfiguration >> beCaseSensitive [
	caseComparison := GtSpotterCaseSensitiveComparison new
]

{ #category : #configuration }
GtSpotterSubstringsFilterConfiguration >> beCaseSensitiveByCapitalization [
	caseComparison := GtSpotterCaseSensitiveByCapitalizationComparison new
]

{ #category : #accessing }
GtSpotterSubstringsFilterConfiguration >> caseComparison [
	^ caseComparison
]

{ #category : #accessing }
GtSpotterSubstringsFilterConfiguration >> caseComparison: anObject [
	caseComparison := anObject
]

{ #category : #initialization }
GtSpotterSubstringsFilterConfiguration >> initialize [ 
	super initialize.
	
	querySplitter := self class defaultQuerySplitter.
	caseComparison := self class defaultCaseComparison.
]

{ #category : #printing }
GtSpotterSubstringsFilterConfiguration >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream 
			<< extensionId asString;
			<< '; ';
			<< caseComparison description;
			<< '; ';
			<< querySplitter description ]
]

{ #category : #accessing }
GtSpotterSubstringsFilterConfiguration >> querySplitter [
	^ querySplitter
]

{ #category : #accessing }
GtSpotterSubstringsFilterConfiguration >> querySplitter: anObject [
	querySplitter := anObject
]

{ #category : #configuration }
GtSpotterSubstringsFilterConfiguration >> withCharacterSplitter [
	querySplitter := GtSpotterByCharacterQuerySplitter new.
]

{ #category : #configuration }
GtSpotterSubstringsFilterConfiguration >> withCharacterSplitterBy: aCollectionOfCharacters [
	querySplitter := GtSpotterByCharacterQuerySplitter new
		wordSeparators: aCollectionOfCharacters.
]

{ #category : #configuration }
GtSpotterSubstringsFilterConfiguration >> withWordsSplitter [
	querySplitter := GtSpotterByWordsQuerySplitter new.
]
