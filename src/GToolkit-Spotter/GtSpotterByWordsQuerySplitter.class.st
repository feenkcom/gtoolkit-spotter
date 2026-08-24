Class {
	#name : #GtSpotterByWordsQuerySplitter,
	#superclass : #GtSpotterByWordsBasicQuerySplitter,
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #printing }
GtSpotterByWordsQuerySplitter >> description [
	^ 'Split by capitalization'
]

{ #category : #testing }
GtSpotterByWordsQuerySplitter >> isExtraWordContinuation: aChar [
	^ aChar isDigit
]
