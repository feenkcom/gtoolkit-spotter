"
I create a preview for a given vertical icon, see {{gtClass:BrGlamorousVectorIcons}}.
I am used by Spotter to nicely display icon previews.


"
Class {
	#name : #GtSpotterVectorIconPreview,
	#superclass : #GtSpotterIconPreview,
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #'instance creation' }
GtSpotterVectorIconPreview >> newIconPreviewElement [
	^ self iconStencil create asElement asScalableElement
		margin: (BlInsets all: 5);
		constraintsDo: [ :c | 
			c linear horizontal alignCenter ]
]
