Class {
	#name : #GtSpotterCaseSensitiveComparison,
	#superclass : #GtSpotterCaseComparison,
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #api }
GtSpotterCaseSensitiveComparison >> applyOnFilterStream: aFilterStream [
	aFilterStream beCaseSensitive
]

{ #category : #printing }
GtSpotterCaseSensitiveComparison >> description [ 
	^ 'Case Sensitive'
]
