Class {
	#name : #GtSpotterUnorderedSearchesStream,
	#superclass : #Object,
	#traits : 'TAsyncStream',
	#classTraits : 'TAsyncStream classTrait',
	#instVars : [
		'origin',
		'stream'
	],
	#category : #'GToolkit-Spotter-Streaming-Streams'
}

{ #category : #'instance creation' }
GtSpotterUnorderedSearchesStream class >> forOriginObject: anObject [
	^ self new forOriginObject: anObject
]

{ #category : #private }
GtSpotterUnorderedSearchesStream >> basicProcessorForPragma: aPragma [
	| aProtoSearch aSearch |
	self flag: 'handle errors and return a "broken" processor'.

	aProtoSearch := GtSpotterProtoSearch new.
	
	"Some #gtSearch extensions do not actually return a processor...
	we have to do a builder hack for now. We will rewrite the extensions!"
	aSearch := origin
		perform: aPragma methodSelector
		with: aProtoSearch.

	aSearch definingMethod: aPragma method.

	^ aSearch
]

{ #category : #initialization }
GtSpotterUnorderedSearchesStream >> buildProcessorsStream [
	^ (GtSpotterSearchPragmasFuture forOriginObject: origin) asAsyncStream flatten
		map: [ :eachPragma | self basicProcessorForPragma: eachPragma ]
]

{ #category : #initialization }
GtSpotterUnorderedSearchesStream >> forOriginObject: anObject [
	origin := anObject.
	stream := self buildProcessorsStream
]

{ #category : #'api - stream' }
GtSpotterUnorderedSearchesStream >> pollNext: anAsynchronousContext [
	"Attempt to pull out the next value of this stream, registering the current task for wakeup if the value is not yet available, and returning None if the stream is exhausted.
	There are several possible return values, each indicating a distinct stream state:
	 - Poll::Pending means that this stream's next value is not ready yet. Implementations will ensure that the current task will be notified when the next value may be ready.
	 - Poll::Ready(Some(val)) means that the stream has successfully produced a value, val, and may produce further values on subsequent poll_next calls.
	 - Poll::Ready(None) means that the stream has terminated, and poll_next should not be invoked again."
	<return: #AsyncPoll>
	
	^ stream pollNext: anAsynchronousContext
]

{ #category : #'api - stream copy' }
GtSpotterUnorderedSearchesStream >> postSimilarCopy [
	"Is called by similarCopy. self is a shallow copy, implementors should set the fields as necessary to complete the similar copy"
	
	stream := self buildProcessorsStream
]