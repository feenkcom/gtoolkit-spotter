Class {
	#name : #GtSpotterDropdownObjectSource,
	#superclass : #GtSpotterDropdownSource,
	#instVars : [
		'object'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #'api - instance creation' }
GtSpotterDropdownObjectSource class >> object: anObject [
	^ self new object: anObject
]

{ #category : #'api - accessing' }
GtSpotterDropdownObjectSource >> object [
	^ object
]

{ #category : #'api - accessing' }
GtSpotterDropdownObjectSource >> object: anObject [ 
	object := anObject
]
