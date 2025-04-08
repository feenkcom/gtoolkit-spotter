Class {
	#name : #GtSpotterQuerySplitter,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #printing }
GtSpotterQuerySplitter >> description [
	^ self class name
]

{ #category : #printing }
GtSpotterQuerySplitter >> printOn: aStream [
	super printOn: aStream.
	
	aStream parenthesize: [
		aStream 
			<< self description ]
]

{ #category : #api }
GtSpotterQuerySplitter >> splitQueryString: aString [
	^ self subclassResponsibility
]
