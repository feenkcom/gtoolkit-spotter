Class {
	#name : 'GtSpotterProcessorLink',
	#superclass : 'DoubleLink',
	#instVars : [
		'headLink',
		'tailLink',
		'size'
	],
	#category : 'GToolkit-Spotter-Utils'
}

{ #category : 'accessing' }
GtSpotterProcessorLink class >> from: aDoubleLink [

	
]

{ #category : 'accessing' }
GtSpotterProcessorLink >> asGtSpotterProcessorLink [

	^ self
]

{ #category : 'actions' }
GtSpotterProcessorLink >> clear [

	self
		headLink: nil;
		tailLink: nil.
		
	size := 0.
]

{ #category : 'printing' }
GtSpotterProcessorLink >> gtDisplayOn: stream [
	stream 
		nextPutAll: 'Processor link: ';
		nextPutAll: self processor title asString
]

{ #category : 'accessing' }
GtSpotterProcessorLink >> headLink [
	^ headLink
]

{ #category : 'accessing' }
GtSpotterProcessorLink >> headLink: anObject [
	headLink := anObject
]

{ #category : 'actions' }
GtSpotterProcessorLink >> incrementSize [

	size := self size + 1
]

{ #category : 'testing' }
GtSpotterProcessorLink >> isEmpty [

	^ self headLink isNil
]

{ #category : 'testing' }
GtSpotterProcessorLink >> isFull [

	^ self size = self processor itemsLimit
]

{ #category : 'accessing' }
GtSpotterProcessorLink >> processor [

	^ self value
]

{ #category : 'accessing' }
GtSpotterProcessorLink >> size [

	^ size ifNil: [ size := 0 ]
]

{ #category : 'accessing' }
GtSpotterProcessorLink >> tailLink [
	^ tailLink
]

{ #category : 'accessing' }
GtSpotterProcessorLink >> tailLink: anObject [
	tailLink := anObject
]
