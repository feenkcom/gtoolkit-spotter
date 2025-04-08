Class {
	#name : #GtSpotterQuerySplitterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #testing }
GtSpotterQuerySplitterExamples class >> isAbstract [
	^ self name = #GtSpotterQuerySplitterExamples
]

{ #category : #assertions }
GtSpotterQuerySplitterExamples >> assertSplitOf: aString equals: aCollection [ 
	| searchWords |
	searchWords := self createQuerySplitter 
		splitQueryString: aString.
	
	self assert: searchWords  asArray equals: aCollection.
	^ searchWords
]

{ #category : #utils }
GtSpotterQuerySplitterExamples >> createQuerySplitter [
	^ self subclassResponsibility
]

{ #category : #examples }
GtSpotterQuerySplitterExamples >> splitEmptyQuery [
	<gtExample>
	^ self 
		assertSplitOf: ''
		equals: #()
]

{ #category : #examples }
GtSpotterQuerySplitterExamples >> splitQueryWithMultipleWords [
	<gtExample>
	self 
		assertSplitOf: 'word1 word2'
		equals: #(word1 word2).
	self 
		assertSplitOf: 'word1 word2 word3'
		equals: #(word1 word2 word3).
]

{ #category : #examples }
GtSpotterQuerySplitterExamples >> splitQueryWithMultipleWordsSeparatedBySpaces [
	<gtExample>
	self 
		assertSplitOf: 'one two'
		equals: #(one two).
	self 
		assertSplitOf: 'one two three'
		equals: #(one two three).
]

{ #category : #examples }
GtSpotterQuerySplitterExamples >> splitQueryWithOneWord [
	<gtExample>
	^ self 
		assertSplitOf: 'word'
		equals: #(word)
]

{ #category : #examples }
GtSpotterQuerySplitterExamples >> splitQueryWithOneWordWithNumber [
	<gtExample>
	^ self 
		assertSplitOf: 'word123'
		equals: #(word123)
]

{ #category : #examples }
GtSpotterQuerySplitterExamples >> splitQueryWithPrefixSuffixSpaces [
	<gtExample>
	self 
		assertSplitOf: ' word'
		equals: #(word).
	self 
		assertSplitOf: 'word '
		equals: #(word).
	self 
		assertSplitOf: '  word   '
		equals: #(word)
]
