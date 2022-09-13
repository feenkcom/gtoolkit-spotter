Class {
	#name : #GtSpotterEmptySearch,
	#superclass : #GtSpotterSearch,
	#category : #'GToolkit-Spotter-Streaming-Searches'
}

{ #category : #converting }
GtSpotterEmptySearch >> asStreamFor: aSpotterContext [
	<return: #TAsyncStream>
	
	^ AsyncEmptyStream new
]
