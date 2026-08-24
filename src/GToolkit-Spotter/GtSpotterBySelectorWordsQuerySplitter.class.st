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
					'+-/\*~<>=@,%|&?!·÷±×' includes: aChar ] ] 
]

{ #category : #splitting }
GtSpotterBySelectorWordsQuerySplitter >> wordsIn: aSymbol do: aBlock minSize: anInteger includeSubStrings: aBoolean [
	| start end char size |
	size := aSymbol size.
	start := 1.
	[ start <= size ]
		whileTrue: [ [ start <= size
				and: [ ((char := aSymbol at: start) isLetter or: [ self isExtraWordContinuation: char ]) not ] ]
				whileTrue: [ start := start + 1 ].
			start > size ifTrue: [ ^ self ].
			end := start + 1.
			char isUppercase
				ifTrue: [ [ end <= size and: [ (aSymbol at: end) isUppercase ] ]
						whileTrue: [ end := end + 1 ] ].
			[ end <= size
				and: [ char := aSymbol at: end.
					char isLowercase or: [ self isExtraWordContinuation: char ] ] ] whileTrue: [ end := end + 1 ].
			(end <= size
				and: [ (aSymbol at: end) = $: ])
					ifTrue: [ end := end + 1 ].
			end := end - 1.
			[ end - start + 1 >= anInteger ]
				whileTrue: [ aBlock cull: (aSymbol copyFrom: start to: end) cull: start.
					(aBoolean and: [ (aSymbol at: end) isUppercase not ])
						ifTrue: [ start := start + 1.
							(start < size and: [ (aSymbol at: start) isUppercase ])
								ifFalse: [ start := end + 1 ] ]
						ifFalse: [ start := end + 1 ] ].
			start := end + 1 ]
]
