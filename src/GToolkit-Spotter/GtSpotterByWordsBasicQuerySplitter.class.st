Class {
	#name : #GtSpotterByWordsBasicQuerySplitter,
	#superclass : #GtSpotterQuerySplitter,
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #utils }
GtSpotterByWordsBasicQuerySplitter >> isExtraWordContinuation: aChar [
	self subclassResponsibility
]

{ #category : #testing }
GtSpotterByWordsBasicQuerySplitter >> splitQueryString: aString [
	| myWords |
	
	myWords := OrderedCollection new.
	self
		wordsIn: aString
		do: [ :each | myWords add: each ]
		minSize: 1
		includeSubStrings: false.
		
	^ myWords
]

{ #category : #utils }
GtSpotterByWordsBasicQuerySplitter >> wordsIn: aSymbol do: aBlock minSize: anInteger includeSubStrings: aBoolean [
	self subclassResponsibility
]
