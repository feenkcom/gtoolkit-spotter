Class {
	#name : #GtSpotterCaseInsensitiveComparison,
	#superclass : #GtSpotterCaseComparison,
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #api }
GtSpotterCaseInsensitiveComparison >> applyOnFilterStream: aFilterStream [
	aFilterStream beCaseInsensitive
]

{ #category : #printing }
GtSpotterCaseInsensitiveComparison >> description [ 
	^ 'Case Insensitive'
]
