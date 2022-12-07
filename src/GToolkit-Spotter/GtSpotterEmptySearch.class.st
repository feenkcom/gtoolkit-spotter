Class {
	#name : #GtSpotterEmptySearch,
	#superclass : #GtSpotterSearch,
	#category : #'GToolkit-Spotter-Searches'
}

{ #category : #converting }
GtSpotterEmptySearch >> asStreamFor: aSpotterContext [
	<return: #TAsyncStream>
	
	^ AsyncEmptyStream new
]

{ #category : #printing }
GtSpotterEmptySearch >> printOn: aStream [
	aStream
		nextPutAll: 'Empty Search'
]
