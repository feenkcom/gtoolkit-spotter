Class {
	#name : #GtSpotterSubstringsFilterStream,
	#superclass : #Object,
	#traits : 'TAsyncStream',
	#classTraits : 'TAsyncStream classTrait',
	#instVars : [
		'scopeStream',
		'searchString',
		'caseSensitive',
		'itemStringBlock',
		'prefixMatches',
		'middleMatches',
		'currentMatchType',
		'currentOtherMatchStream',
		'searchWords',
		'caseSensitiveByCapitalization'
	],
	#classVars : [
		'ExactMatch',
		'MiddleMatch',
		'NoMatch',
		'PrefixMatch'
	],
	#category : #'GToolkit-Spotter-Streams'
}

{ #category : #'instance creation' }
GtSpotterSubstringsFilterStream class >> forStream: aStream search: aSearchString [
	^ self new
		stream: aStream
		search: aSearchString
]

{ #category : #'instance creation' }
GtSpotterSubstringsFilterStream class >> forStream: aStream search: aSearchString words: aCollectionOfWords [
	^ self new
		stream: aStream
		search: aSearchString
		words: aCollectionOfWords
]

{ #category : #initialization }
GtSpotterSubstringsFilterStream class >> initialize [
	ExactMatch := GtSpotterSubstringFilterExactMatch.
	PrefixMatch := GtSpotterSubstringFilterPrefixMatch.
	MiddleMatch := GtSpotterSubstringFilterMiddleMatch.
	NoMatch := GtSpotterSubstringFilterNoMatch
]

{ #category : #'api - configuration' }
GtSpotterSubstringsFilterStream >> beCaseInsensitive [
	caseSensitive := false
]

{ #category : #'api - configuration' }
GtSpotterSubstringsFilterStream >> beCaseSensitive [
	caseSensitive := true
]

{ #category : #'api - configuration' }
GtSpotterSubstringsFilterStream >> beCaseSensitiveByCapitalization [
	caseSensitiveByCapitalization := true.
]

{ #category : #'api - configuration' }
GtSpotterSubstringsFilterStream >> caseSensitive: aBoolean [
	caseSensitive := aBoolean
]

{ #category : #initialization }
GtSpotterSubstringsFilterStream >> initialize [
	super initialize.
	
	caseSensitive := false.
	caseSensitiveByCapitalization := false.
	itemStringBlock := [ :anObject | anObject printString ]
]

{ #category : #'api - configuration' }
GtSpotterSubstringsFilterStream >> itemString: aBlock [
	itemStringBlock := aBlock
]

{ #category : #'private - filter' }
GtSpotterSubstringsFilterStream >> itemStringOf: anObject [
	^ itemStringBlock value: anObject
]

{ #category : #'private - filter' }
GtSpotterSubstringsFilterStream >> pollMiddleStream: anAsynchronousContext [
	self
		assert: [ currentMatchType = MiddleMatch ]
		description: [ 'Can only poll if matching middle type' ].

	^ (currentOtherMatchStream pollNext: anAsynchronousContext)
		ifReady: [ :aReadyPoll |
			aReadyPoll value isNone
				ifTrue: [
					currentMatchType := NoMatch.
					currentOtherMatchStream := AsyncEmptyStream new ].
			aReadyPoll ]
]

{ #category : #'api - stream' }
GtSpotterSubstringsFilterStream >> pollNext: anAsynchronousContext [
	"Attempt to pull out the next value of this stream, registering the current task for wakeup if the value is not yet available, and returning None if the stream is exhausted.
	There are several possible return values, each indicating a distinct stream state:
	 - Poll::Pending means that this stream's next value is not ready yet. Implementations will ensure that the current task will be notified when the next value may be ready.
	 - Poll::Ready(Some(val)) means that the stream has successfully produced a value, val, and may produce further values on subsequent poll_next calls.
	 - Poll::Ready(None) means that the stream has terminated, and poll_next should not be invoked again."
	<return: #AsyncPoll>

	[ currentMatchType = ExactMatch
		ifTrue: [
			(self pollScopeStream: anAsynchronousContext)
				ifNotNil: [ :anAsyncPoll | ^ anAsyncPoll ] ]
		ifFalse: [
			currentMatchType = PrefixMatch
				ifTrue: [
					(self pollPrefixStream: anAsynchronousContext)
						ifNotNil: [ :anAsyncPoll | ^ anAsyncPoll ] ]
				ifFalse: [ 
					currentMatchType = MiddleMatch
						ifTrue: [
							(self pollMiddleStream: anAsynchronousContext)
								ifNotNil: [ :anAsyncPoll | ^ anAsyncPoll ] ]
						ifFalse: [ ^ AsyncPoll ready: AsyncOptionalValue none ]
				] ] ] repeat
]

{ #category : #'private - filter' }
GtSpotterSubstringsFilterStream >> pollPrefixStream: anAsynchronousContext [
	self
		assert: [ currentMatchType = PrefixMatch ]
		description: [ 'Can only poll if matching prefix type' ].

	(currentOtherMatchStream pollNext: anAsynchronousContext)
		ifReady: [ :aReadyPoll |
			aReadyPoll value
				ifSome: [ ^ aReadyPoll ]
				ifNone: [ self tryToSwitchToMiddleMatches ] ]
		ifPending: [ :aPendingPoll | ^ aPendingPoll ].
	
	"we need another loop"
	^ nil
]

{ #category : #'private - filter' }
GtSpotterSubstringsFilterStream >> pollScopeStream: anAsynchronousContext [
	(scopeStream pollNext: anAsynchronousContext)
		ifReady: [ :aReadyPoll |
			aReadyPoll value
				ifSome: [ :anObject |
					| aString aMatch |
	
					aString := self itemStringOf: anObject.
					aMatch := self searchSubstringIn: aString.

					"we found an exact match, we can return it directly"
					aMatch isExact
						ifTrue: [ ^ aReadyPoll ].
						
					aMatch isPrefix
						ifTrue: [ prefixMatches add: anObject ].
						
					aMatch isMiddle
						ifTrue: [ middleMatches add: anObject ] ]
				ifNone: [ self tryToSwitchToPrefixMatches ] ]
		ifPending: [ :aPendingPoll | ^ aPendingPoll ].

	^ nil
]

{ #category : #'api - stream copy' }
GtSpotterSubstringsFilterStream >> postSimilarCopy [
	"Is called by similarCopy. self is a shallow copy, implementors should set the fields as necessary to complete the similar copy"
	
	self
		stream: scopeStream asyncSimilarCopy
		search: searchString
]

{ #category : #'private - filter' }
GtSpotterSubstringsFilterStream >> searchSubstringIn: aString [
	<return: #GtSpotterSubstringFilterMatch>
	| resultIndexes |

	resultIndexes := searchWords collect: [ :aQueryWord |
		"Do a search for every "
		aString 
			findString: aQueryWord
			startingAt: 1 
			caseSensitive: (caseSensitive or: [
				caseSensitiveByCapitalization and: [
					aQueryWord first isUppercase ] ]) ].
		
	(searchWords size = 1 and: [ 
		resultIndexes first = 1 and: [ 
			aString size = searchWords first size ] ])
		ifTrue: [ 
			^ GtSpotterSubstringFilterExactMatch new index: resultIndexes first ].
		
	"The search does an and between the search words. If any word
	is not found return a no match"
	(resultIndexes isEmpty or: [
		resultIndexes anySatisfy: [ :anIndex | anIndex < 1 ] ])
			ifTrue: [ 
				^ GtSpotterSubstringFilterNoMatch new index: 0 ].
	
	resultIndexes 
		detect: [ :anIndex | anIndex = 1 ]
		ifFound: [ :anIndex | 
			^ GtSpotterSubstringFilterPrefixMatch new index: anIndex ].
			
	^ GtSpotterSubstringFilterMiddleMatch new 
		index: (resultIndexes 
			ifEmpty: [0] 
			ifNotEmpty: [ :aCollection | aCollection first ] )
]

{ #category : #accessing }
GtSpotterSubstringsFilterStream >> searchWords [
	^ searchWords
]

{ #category : #'api - configuration' }
GtSpotterSubstringsFilterStream >> searchWords: aCollection [
	searchWords := aCollection
]

{ #category : #initialization }
GtSpotterSubstringsFilterStream >> stream: aStream search: aSearchString [
	self 
		stream: aStream 
		search: aSearchString 
		words: ((aSearchString trimBoth splitOn: Character space) 
			reject: [ :each | each isEmpty ]).
]

{ #category : #initialization }
GtSpotterSubstringsFilterStream >> stream: aStream search: aSearchString words: aCollectionOfWords [
	scopeStream := aStream.
	searchString := aSearchString.
	searchWords := aCollectionOfWords.
	prefixMatches := OrderedCollection new.
	middleMatches := OrderedCollection new.
	currentMatchType := ExactMatch.
	currentOtherMatchStream := AsyncEmptyStream new
]

{ #category : #'private - filter' }
GtSpotterSubstringsFilterStream >> tryToSwitchToMiddleMatches [
	middleMatches
		ifEmpty: [
			"no interesting matches found, we are done"
			currentMatchType := NoMatch.
			currentOtherMatchStream := AsyncEmptyStream new ]
		ifNotEmpty: [ :theMiddleMatches |
			currentMatchType := MiddleMatch.
			currentOtherMatchStream := theMiddleMatches asAsyncStream ]
]

{ #category : #'private - filter' }
GtSpotterSubstringsFilterStream >> tryToSwitchToPrefixMatches [
	prefixMatches
		ifEmpty: [ self tryToSwitchToMiddleMatches ]
		ifNotEmpty: [ :thePrefixMatches |
			currentMatchType := PrefixMatch.
			currentOtherMatchStream := thePrefixMatches asAsyncStream ]
]
