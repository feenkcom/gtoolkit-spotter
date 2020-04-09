"
I create a preview for a given vertical icon, see ${class:BrGlamorousVectorIcons}$.
I am used by Spotter to nicely display icon previews.
"
Class {
	#name : #GtSpotterVectorIconPreview,
	#superclass : #GtSpotterIconPreview,
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #'api - instantiation' }
GtSpotterVectorIconPreview >> asElement [
	<return: #BlElement>
	^ BrVerticalPane new matchParent
		addChild: self newEditorAndClipboardElement;
		addChild: self newIconPreviewElement;
		margin: (BlInsets all: 5)
]

{ #category : #accessing }
GtSpotterVectorIconPreview >> iconCreationCode [
	<return: #String>
	^ self iconLibrary asString , ' ' , self iconSelector asString
]

{ #category : #accessing }
GtSpotterVectorIconPreview >> iconCreationCodeRope [
	<return: #BlRope>
	^ self iconCreationCode asRopedText 
		attribute: (BrTextAdornmentDynamicAttribute new 
			beAppend;
			stencil: [ self newClipboardElement])
]

{ #category : #'api - instantiation' }
GtSpotterVectorIconPreview >> newClipboardElement [
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
GtSpotterVectorIconPreview >> newCodeEditor [
	^ BrEditor new
		look: BrGlamorousCodeEditorLook;
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
GtSpotterVectorIconPreview >> newEditorAndClipboardElement [
	^ BrHorizontalPane new fitContent
		addChild: self newCodeEditor;
		addChild: self newClipboardElement;
		constraintsDo: [ :c | 
			c linear horizontal alignCenter ]
]

{ #category : #'api - instantiation' }
GtSpotterVectorIconPreview >> newIconPreviewElement [
	^ self iconStencil create asElement asScalableElement
		margin: (BlInsets all: 5);
		constraintsDo: [ :c | 
			c linear horizontal alignCenter ]
]
