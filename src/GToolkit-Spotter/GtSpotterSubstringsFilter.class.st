Class {
	#name : #GtSpotterSubstringsFilter,
	#superclass : #Object,
	#traits : 'TGtSpotterFilter',
	#classTraits : 'TGtSpotterFilter classTrait',
	#instVars : [
		'itemStringComputation',
		'filterConfiguration'
	],
	#category : #'GToolkit-Spotter-Filters'
}

{ #category : #configuration }
GtSpotterSubstringsFilter >> applyConfigurationWithId: aFilterConfigurationId inContext: aSpotterContext [
	aSpotterContext filtersConfiguration
		applyConfigurationWithId: aFilterConfigurationId 
		onFilter: self
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
GtSpotterSubstringsFilter >> beCaseInsensitive [
	filterConfiguration beCaseInsensitive
]

{ #category : #configuration }
GtSpotterSubstringsFilter >> beCaseSensitive [
	filterConfiguration beCaseSensitive
]

{ #category : #configuration }
GtSpotterSubstringsFilter >> beCaseSensitiveByCapitalization [
	filterConfiguration beCaseSensitiveByCapitalization
]

{ #category : #accessing }
GtSpotterSubstringsFilter >> caseComparison [
	^ filterConfiguration caseComparison
]

{ #category : #accessing }
GtSpotterSubstringsFilter >> caseComparison: aCaseComparison [
	filterConfiguration caseComparison: aCaseComparison
]

{ #category : #evaluating }
GtSpotterSubstringsFilter >> configureFilterStream: aFilterStream inContext: aSpotterContext [
	| searchWords |
	
	aFilterStream itemString: itemStringComputation.
	 
	searchWords := self 
		wordsFromQueryString: aSpotterContext searchQuery.
	aFilterStream searchWords: searchWords.

	self caseComparison applyOnFilterStream: aFilterStream.
]

{ #category : #accessing }
GtSpotterSubstringsFilter >> defaultConfiguration [
	^ GtSpotterSubstringsFilterConfiguration new 
]

{ #category : #initialization }
GtSpotterSubstringsFilter >> initialize [
	super initialize.
	
	itemStringComputation := [ :anObject | anObject printString ].
	filterConfiguration := self defaultConfiguration.
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
	^ filterConfiguration querySplitter
]

{ #category : #accessing }
GtSpotterSubstringsFilter >> querySplitter: aQuerySplitter [
	filterConfiguration querySplitter: aQuerySplitter
]

{ #category : #configuration }
GtSpotterSubstringsFilter >> withCharacterSplitter [
	filterConfiguration withCharacterSplitter
]

{ #category : #configuration }
GtSpotterSubstringsFilter >> withCharacterSplitterBy: aCollectionOfCharacters [
	filterConfiguration withCharacterSplitterBy: aCollectionOfCharacters
]

{ #category : #configuration }
GtSpotterSubstringsFilter >> withWordsSplitter [
	filterConfiguration withWordsSplitter
]

{ #category : #utils }
GtSpotterSubstringsFilter >> wordsFromQueryString: aQueryString [ 
	^ self querySplitter splitQueryString: aQueryString
]
