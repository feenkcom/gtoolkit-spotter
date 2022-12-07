Class {
	#name : #GtSpotterBrokenSearch,
	#superclass : #GtSpotterProtoSearch,
	#instVars : [
		'error'
	],
	#category : #'GToolkit-Spotter-Searches'
}

{ #category : #converting }
GtSpotterBrokenSearch >> asStreamFor: aSpotterContext [
	<return: #TAsyncStream>
	
	^ { self } asAsyncStream
]

{ #category : #accessing }
GtSpotterBrokenSearch >> error [
	^ error
]

{ #category : #accessing }
GtSpotterBrokenSearch >> error: anError [
	error := anError copy freeze
]

{ #category : #testing }
GtSpotterBrokenSearch >> hasCategoryActOn [
	^ false
]

{ #category : #testing }
GtSpotterBrokenSearch >> isBroken [
	^ true
]
