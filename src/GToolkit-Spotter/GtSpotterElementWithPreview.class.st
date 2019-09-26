Class {
	#name : #GtSpotterElementWithPreview,
	#superclass : #GtSpotterElement,
	#instVars : [
		'previewElement'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #initialization }
GtSpotterElementWithPreview >> initialize [
	super initialize.
	
	previewElement := GtSpotterPreviewElement new.
	results addPage: previewElement
]

{ #category : #accessing }
GtSpotterElementWithPreview >> preview [
	^ previewElement
]

{ #category : #accessing }
GtSpotterElementWithPreview >> spotterModel [
	^ spotterModel
]

{ #category : #accessing }
GtSpotterElementWithPreview >> spotterModel: aSpotterModel [
	super spotterModel: aSpotterModel.
	self preview spotterModel: aSpotterModel
]
