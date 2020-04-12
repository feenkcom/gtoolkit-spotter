Class {
	#name : #GtSpotterPixelIconPreview,
	#superclass : #GtSpotterIconPreview,
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #'instance creation' }
GtSpotterPixelIconPreview >> newIconPreviewElement [
	^ BrFrame new matchParent
		addChild: self newIconPreviewElementOfStandardSize;
		constraintsDo: [ :c | c linear horizontal alignCenter ]
]

{ #category : #'instance creation' }
GtSpotterPixelIconPreview >> newIconPreviewElementOfDoubleSize [
	^ BlElement new
		size: 32@32;
		addChild: (self iconStencil create asElement asScalableElement
			margin: (BlInsets all: 5));
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ]
]

{ #category : #'instance creation' }
GtSpotterPixelIconPreview >> newIconPreviewElementOfStandardSize [
	^ self iconStencil create asElement
		margin: (BlInsets all: 5);
		constraintsDo: [ :c | 
			c frame horizontal alignCenter.
			c frame vertical alignCenter ]
]
