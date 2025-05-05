Class {
	#name : #GtSpotterCustomSubstringsFilterStreamExamples,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #testing }
GtSpotterCustomSubstringsFilterStreamExamples class >> isAbstract [
	^ self name = #GtSpotterCustomSubstringsFilterStreamExamples
]

{ #category : #assertions }
GtSpotterCustomSubstringsFilterStreamExamples >> assertQuerySearch: aQueryString in: aStream equals: aResult [
	| filterStream |
	
	filterStream := self 
		createFilterWithQuerySearch: aQueryString 
		in: aStream asAsyncStream .
		
	self 
		assert: filterStream toArray wait
		equals: aResult
]

{ #category : #assertions }
GtSpotterCustomSubstringsFilterStreamExamples >> assertQuerySearches: aListOfQueries in: aStream equals: aResult [
	self assert: aListOfQueries size > 0 description: 'At least one query should be provided'.
	
	aListOfQueries do: [ : aQueryString |
		self assertQuerySearch: aQueryString in: aStream equals: aResult ]
]

{ #category : #utils }
GtSpotterCustomSubstringsFilterStreamExamples >> configureSpotterFilter: aSpotterFilter [
]

{ #category : #utils }
GtSpotterCustomSubstringsFilterStreamExamples >> createFilterWithQuerySearch: aQueryString in: aStream [ 
	| spotterFilter |
	spotterFilter := GtSpotterSubstringsFilter new.
	self configureSpotterFilter: spotterFilter.
	
	^ spotterFilter
		applyInScope: aStream 
		context: (GtSpotterContext new
			searchQuery:  aQueryString)
]

{ #category : #examples }
GtSpotterCustomSubstringsFilterStreamExamples >> testExactFullMatch [
	<gtExample>
	<return: #GtSpotterCustomSubstringsFilterStreamExamples>
	self
		assertQuerySearch: 'StringOne'
		in: #('StringOne' 'StringTwo' 'StringThree')
		equals: #('StringOne').

	self
		assertQuerySearch: 'StringTwo'
		in: #('StringOne' 'StringTwo' 'StringThree')
		equals: #('StringTwo')
]

{ #category : #examples }
GtSpotterCustomSubstringsFilterStreamExamples >> testPrefixMatch_exactMatch [
	<gtExample>
	<return: #GtSpotterCustomSubstringsFilterStreamExamples>
	self
		assertQuerySearch: 'One'
		in: #('OneString' 'TwoString' 'ThreeString')
		equals: #('OneString').

	self
		assertQuerySearch: 'Two'
		in: #('OneString' 'TwoString' 'ThreeString')
		equals: #('TwoString')
]

{ #category : #examples }
GtSpotterCustomSubstringsFilterStreamExamples >> testPrefixMatch_multipleMatches [
	<gtExample>
	<return: #GtSpotterCustomSubstringsFilterStreamExamples>
	self
		assertQuerySearch: 'String'
		in: #('StringOne' 'StringTwo' 'StringThree')
		equals: #('StringOne' 'StringTwo' 'StringThree')
]

{ #category : #examples }
GtSpotterCustomSubstringsFilterStreamExamples >> testSuffixMatch_exactMatch [
	<gtExample>
	<return: #GtSpotterCustomSubstringsFilterStreamExamples>
	self
		assertQuerySearch: 'One'
		in: #('StringOne' 'StringTwo' 'StringThree')
		equals: #('StringOne').

	self
		assertQuerySearch: 'Two'
		in: #('StringOne' 'StringTwo' 'StringThree')
		equals: #('StringTwo')
]

{ #category : #examples }
GtSpotterCustomSubstringsFilterStreamExamples >> testSuffixMatch_multipleMatches [
	<gtExample>
	<return: #GtSpotterCustomSubstringsFilterStreamExamples>
	self
		assertQuerySearch: 'String'
		in: #('OneString' 'TwoString' 'ThreeString')
		equals: #('OneString' 'TwoString' 'ThreeString')
]
