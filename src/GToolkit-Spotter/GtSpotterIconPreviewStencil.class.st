Class {
	#name : #GtSpotterIconPreviewStencil,
	#superclass : #BrStencil,
	#instVars : [
		'iconLibrary',
		'iconSelector',
		'iconStencil'
	],
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #testing }
GtSpotterIconPreviewStencil class >> isAbstract [
	^ self name = #GtSpotterIconPreviewStencil 
]

{ #category : #'instance creation' }
GtSpotterIconPreviewStencil class >> library: aClass allIcons: aCollection [
	^ aCollection collect: [ :eachAssociation |
		self library: aClass iconAssotiation: eachAssociation ]
]

{ #category : #'instance creation' }
GtSpotterIconPreviewStencil class >> library: aClass iconAssotiation: anAssociation [
	^ self new
		iconLibrary: aClass;
		iconSelector: anAssociation key;
		iconStencil: anAssociation value
]

{ #category : #accessing }
GtSpotterIconPreviewStencil >> iconLibrary [
	^ iconLibrary
]

{ #category : #accessing }
GtSpotterIconPreviewStencil >> iconLibrary: anObject [
	iconLibrary := anObject
]

{ #category : #accessing }
GtSpotterIconPreviewStencil >> iconSelector [
	^ iconSelector
]

{ #category : #accessing }
GtSpotterIconPreviewStencil >> iconSelector: anObject [
	iconSelector := anObject
]

{ #category : #accessing }
GtSpotterIconPreviewStencil >> iconStencil [
	^ iconStencil
]

{ #category : #accessing }
GtSpotterIconPreviewStencil >> iconStencil: anObject [
	iconStencil := anObject
]
