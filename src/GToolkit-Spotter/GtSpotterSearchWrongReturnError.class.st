Class {
	#name : #GtSpotterSearchWrongReturnError,
	#superclass : #Error,
	#instVars : [
		'definingMethod'
	],
	#category : #'GToolkit-Spotter-Exceptions'
}

{ #category : #accessing }
GtSpotterSearchWrongReturnError >> definingMethod [

	^ definingMethod
]

{ #category : #accessing }
GtSpotterSearchWrongReturnError >> definingMethod: anObject [

	definingMethod := anObject
]
