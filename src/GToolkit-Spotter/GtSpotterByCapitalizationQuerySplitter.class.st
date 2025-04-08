Class {
	#name : #GtSpotterByCapitalizationQuerySplitter,
	#superclass : #GtSpotterQuerySplitter,
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #printing }
GtSpotterByCapitalizationQuerySplitter >> description [
	^ 'Split by capitalization'
]

{ #category : #api }
GtSpotterByCapitalizationQuerySplitter >> splitQueryString: aString [
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
GtSpotterByCapitalizationQuerySplitter >> wordsIn: aSymbol do: aBlock minSize: anInteger includeSubStrings: aBoolean [
	| start end char size  |
	size := aSymbol size.
	start := 1.
	[ start <= size ]
		whileTrue: [ [ start <= size
				and: [ ((char := aSymbol at: start) isLetter or: [ char isDigit ]) not ] ]
				whileTrue: [ start := start + 1 ].
			start > size ifTrue: [ ^ self ].
			end := start + 1.
			char isUppercase
				ifTrue: [ [ end <= size and: [ (aSymbol at: end) isUppercase ] ]
						whileTrue: [ end := end + 1 ] ].

			[ end <= size
				and: [ char := aSymbol at: end.
					char isLowercase or: [char isDigit ] ] ]
				whileTrue: [ end := end + 1 ].
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
