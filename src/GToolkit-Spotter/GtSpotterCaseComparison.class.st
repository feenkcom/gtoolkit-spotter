Class {
	#name : #GtSpotterCaseComparison,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #api }
GtSpotterCaseComparison >> applyOnFilterStream: aFilterStream [
	self subclassResponsibility
]

{ #category : #printing }
GtSpotterCaseComparison >> description [ 
	^ self class name
]
