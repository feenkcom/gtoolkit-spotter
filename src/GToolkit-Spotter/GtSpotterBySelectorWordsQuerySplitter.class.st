Class {
	#name : #GtSpotterBySelectorWordsQuerySplitter,
	#superclass : #GtSpotterByWordsBasicQuerySplitter,
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #printing }
GtSpotterBySelectorWordsQuerySplitter >> description [
	^ 'Split by capitalization for method selectors'
]

{ #category : #testing }
GtSpotterBySelectorWordsQuerySplitter >> isExtraWordContinuation: aChar [
	^ aChar isDigit or: [ 
			aChar = $_  or: [
				aChar = $:  or: [
					'+-/\*~<>=@,%|&?!·÷±×' includes: aChar ] ] ]
]
