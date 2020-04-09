Class {
	#name : #GtSpotterVectorIconPreviewStencil,
	#superclass : #GtSpotterIconPreviewStencil,
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #'api - instantiation' }
GtSpotterVectorIconPreviewStencil >> create [
	<return: #BlElement>
	^ BrVerticalPane new matchParent
		addChild: self newEditorAndClipboardElement;
		addChild: self newIconPreviewElement
]

{ #category : #accessing }
GtSpotterVectorIconPreviewStencil >> iconCreationCode [
	<return: #String>
	^ self iconLibrary asString , ' ' , self iconSelector asString
]

{ #category : #accessing }
GtSpotterVectorIconPreviewStencil >> iconCreationCodeRope [
	<return: #BlRope>
	^ self iconCreationCode asRopedText 
		attribute: (BrTextAdornmentDynamicAttribute new 
			beAppend;
			stencil: [ self newClipboardElement])
]

{ #category : #'api - instantiation' }
GtSpotterVectorIconPreviewStencil >> newClipboardElement [
	^ BrButton new
		"look: BrGlamorousButtonRectangularLook + BrGlamorousButtonIconLook + BrGlamorousWithLabelTooltipLook;"
		look: BrGlamorousButtonWithIconLook;
		icon: BrGlamorousVectorIcons clipboard;
		label: 'Copy to clipboard' translated;
		action: [ :aButton | 
			Clipboard clipboardText: self iconCreationCode. ];
		constraintsDo: [ :c | 
			c linear vertical alignCenter ]
]

{ #category : #'api - instantiation' }
GtSpotterVectorIconPreviewStencil >> newCodeEditor [
	^ BrEditor new
		look: BrGlamorousCodeEditorLook + BrShadowLook;
		beReadOnlyWithSelection;
		background: Color white;
		margin: (BlInsets all: 5);
		vFitContent;
		hFitContent;
		text: self iconCreationCode;
		constraintsDo: [ :c | 
			c linear vertical alignCenter ]
]

{ #category : #'instance creation' }
GtSpotterVectorIconPreviewStencil >> newEditorAndClipboardElement [
	^ BrHorizontalPane new fitContent
		addChild: self newCodeEditor;
		addChild: self newClipboardElement;
		constraintsDo: [ :c | 
			c linear horizontal alignCenter ]
]

{ #category : #'api - instantiation' }
GtSpotterVectorIconPreviewStencil >> newIconPreviewElement [
	^ self iconStencil create asElement asScalableElement
		margin: (BlInsets all: 5);
		constraintsDo: [ :c | 
			c linear horizontal alignCenter ]
]
