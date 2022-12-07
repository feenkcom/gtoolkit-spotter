Class {
	#name : #GtSpotterOrderedSearchesStream,
	#superclass : #Object,
	#traits : 'TAsyncStream',
	#classTraits : 'TAsyncStream classTrait',
	#instVars : [
		'stream'
	],
	#category : #'GToolkit-Spotter-Streams'
}

{ #category : #'instance creation' }
GtSpotterOrderedSearchesStream class >> forOriginObject: anObject [
	^ self
		forOriginObject: anObject
		context: GtStreamingSpotterContext new
]

{ #category : #'instance creation' }
GtSpotterOrderedSearchesStream class >> forOriginObject: anObject context: aSpotterContext [
	^ self forSearches: (GtSpotterUnorderedSearchesStream forOriginObject: anObject context: aSpotterContext)
]

{ #category : #'instance creation' }
GtSpotterOrderedSearchesStream class >> forSearches: aStreamOfSearches [
	^ self new forSearches: aStreamOfSearches
]

{ #category : #initialization }
GtSpotterOrderedSearchesStream >> buildSearchesStream: aStreamOfSearches [
	^ ((aStreamOfSearches toArray map: [ :anArrayOfProcessors | (anArrayOfProcessors sorted: [ :a :b | a priority < b priority ]) asAsyncStream ]))
			asAsyncStream flatten
]

{ #category : #initialization }
GtSpotterOrderedSearchesStream >> forSearches: aStreamOfSearches [
	stream := self buildSearchesStream: aStreamOfSearches asAsyncStream
]

{ #category : #'api - stream' }
GtSpotterOrderedSearchesStream >> pollNext: anAsynchronousContext [
	"Attempt to pull out the next value of this stream, registering the current task for wakeup if the value is not yet available, and returning None if the stream is exhausted.
	There are several possible return values, each indicating a distinct stream state:
	 - Poll::Pending means that this stream's next value is not ready yet. Implementations will ensure that the current task will be notified when the next value may be ready.
	 - Poll::Ready(Some(val)) means that the stream has successfully produced a value, val, and may produce further values on subsequent poll_next calls.
	 - Poll::Ready(None) means that the stream has terminated, and poll_next should not be invoked again."
	<return: #AsyncPoll>
	
	^ stream pollNext: anAsynchronousContext
]

{ #category : #'api - stream copy' }
GtSpotterOrderedSearchesStream >> postSimilarCopy [
	"Is called by similarCopy. self is a shallow copy, implementors should set the fields as necessary to complete the similar copy"

	stream := stream asyncSimilarCopy
]
