Extension { #name : #GtSpotterSearch }

{ #category : #'*GToolkit-Spotter-UI' }
GtSpotterSearch >> previewElementFor: anObject [
	<return: #BlElement or: nil>
	
	^ previewElementComputation
		ifNil: [ self privateDefaultPreviewElementFor: anObject ]
		ifNotNil: [ :aBlock | aBlock cull: anObject ]
]

{ #category : #'*GToolkit-Spotter-UI' }
GtSpotterSearch >> privateDefaultPreviewElementFor: anObject [
	<return: #BlElement or: nil>
	| aPreviewElement |
	
	aPreviewElement := nil.

	(anObject gtViewsFor: GtPhlowView empty) originalView
		asElementDo: [ :anElement | aPreviewElement := anElement ].

	^ aPreviewElement
]
