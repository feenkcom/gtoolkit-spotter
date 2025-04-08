Class {
	#name : #GtSpotterFilterConfiguration,
	#superclass : #Object,
	#instVars : [
		'extensionId'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #api }
GtSpotterFilterConfiguration >> applyOnFilter: aSearchFilter [
	self subclassResponsibility
]

{ #category : #accessing }
GtSpotterFilterConfiguration >> extensionId [
	^ extensionId
]

{ #category : #accessing }
GtSpotterFilterConfiguration >> extensionId: anObject [
	extensionId := anObject
]
