Class {
	#name : #GtSpotterCaseSensitiveByCapitalizationComparison,
	#superclass : #GtSpotterCaseComparison,
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #api }
GtSpotterCaseSensitiveByCapitalizationComparison >> applyOnFilterStream: aFilterStream [
	aFilterStream beCaseSensitiveByCapitalization
]

{ #category : #printing }
GtSpotterCaseSensitiveByCapitalizationComparison >> description [ 
	^ 'Case Sensitive by Capitalization'
]
