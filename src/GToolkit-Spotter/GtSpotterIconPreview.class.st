"
I am an abstract method.
My subclasses know how to create an icon preview.
My subclasses are used by Spotter to nicely display icon previews.
"
Class {
	#name : #GtSpotterIconPreview,
	#superclass : #Object,
	#instVars : [
		'iconLibrary',
		'iconSelector',
		'iconStencil'
	],
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #testing }
GtSpotterIconPreview class >> isAbstract [
	^ self name = #GtSpotterIconPreview 
]

{ #category : #'instance creation' }
GtSpotterIconPreview class >> library: aClass allIcons: aCollection [
	^ aCollection collect: [ :eachAssociation |
		self library: aClass iconAssotiation: eachAssociation ]
]

{ #category : #'instance creation' }
GtSpotterIconPreview class >> library: aClass iconAssotiation: anAssociation [
	^ self new
		iconLibrary: aClass;
		iconSelector: anAssociation key;
		iconStencil: anAssociation value
]

{ #category : #converting }
GtSpotterIconPreview >> asElement [
	<return: #BlElement>
	^ self subclassResponsibility
]

{ #category : #ui }
GtSpotterIconPreview >> gtLiveFor: aView [
	<gtView>
	self class isAbstract ifTrue: [ ^ aView empty ].
	self iconLibrary ifNil: [ ^ aView empty ].
	self iconSelector ifNil: [ ^ aView empty ].
	self iconStencil ifNil: [ ^ aView empty ].
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: self
]

{ #category : #accessing }
GtSpotterIconPreview >> iconLibrary [
	^ iconLibrary
]

{ #category : #accessing }
GtSpotterIconPreview >> iconLibrary: anObject [
	iconLibrary := anObject
]

{ #category : #accessing }
GtSpotterIconPreview >> iconSelector [
	^ iconSelector
]

{ #category : #accessing }
GtSpotterIconPreview >> iconSelector: anObject [
	iconSelector := anObject
]

{ #category : #accessing }
GtSpotterIconPreview >> iconStencil [
	^ iconStencil
]

{ #category : #accessing }
GtSpotterIconPreview >> iconStencil: anObject [
	iconStencil := anObject
]
