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
GtSpotterIconPreview class >> library: aClass allForms: aCollection [
	"aCollection includes associations with 
		- key: a selector
		- value: a Form"
	^ aCollection collect: [ :eachAssociation |
		| withStencil |
		withStencil := (eachAssociation key -> 
			([ eachAssociation value asElement ] asStencil)).
		self 
			library: aClass 
			iconAssotiation: withStencil ]
]

{ #category : #'instance creation' }
GtSpotterIconPreview class >> library: aClass allIcons: aCollection [
	"aCollection includes associations with 
		- key: a selector
		- value: a stencil"
	^ aCollection collect: [ :eachAssociation |
		self library: aClass iconAssotiation: eachAssociation ]
]

{ #category : #'instance creation' }
GtSpotterIconPreview class >> library: aClass iconAssotiation: anAssociation [
	"anAssociation has the following values: 
		- key: a selector
		- value: a stencil"
	^ self new
		iconLibrary: aClass;
		iconSelector: anAssociation key;
		iconStencil: anAssociation value
]

{ #category : #converting }
GtSpotterIconPreview >> asElement [
	<return: #BlElement>
	^ BrVerticalPane new matchParent
		addChild: self newEditorAndClipboardElement;
		addChild: self newIconPreviewElement;
		margin: (BlInsets all: 5)
]

{ #category : #convenience }
GtSpotterIconPreview >> classThatIncludesSelector [ 
	<return: #Behavior or: nil>
	^ self iconLibrary class whichClassIncludesSelector: self iconSelector.
]

{ #category : #ui }
GtSpotterIconPreview >> gtLiveFor: aView [
	<gtView>
	self isDefined ifFalse: [ ^ aView empty ].
	^ aView explicit
		title: 'Live';
		priority: 1;
		stencil: self
]

{ #category : #ui }
GtSpotterIconPreview >> gtMethodFor: aView [
	<gtView>
	self isDefined ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Method';
		priority: 5;
		object: [ self method ];
		view: #gtSourceFor:
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

{ #category : #testing }
GtSpotterIconPreview >> isDefined [
	<return: #Boolean>
	^ self class isAbstract not and: [ 
		self isMethodDefined and: [ 
				self iconStencil isNotNil ] ].
]

{ #category : #testing }
GtSpotterIconPreview >> isMethodDefined [
	<return: #Boolean>
	^ self method isNotNil
]

{ #category : #convenience }
GtSpotterIconPreview >> method [
	<return: #CompiledMethod or: nil>
	^ self classThatIncludesSelector 
		ifNotNil: [ :theClass | theClass >> self iconSelector ] 
		ifNil: [ nil ]
]

{ #category : #'instance creation' }
GtSpotterIconPreview >> newClipboardElement [
	^ BrButton new
		"look: BrGlamorousButtonRectangularLook + BrGlamorousButtonIconLook + BrGlamorousWithLabelTooltipLook;"
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons clipboard;
		label: 'Copy to clipboard' translated;
		action: [ :aButton | 
			Clipboard clipboardText: self newIconCreationCode. ];
		constraintsDo: [ :c | 
			c linear vertical alignCenter ]
]

{ #category : #'instance creation' }
GtSpotterIconPreview >> newCodeEditor [
	^ BrEditor new
		aptitude: BrGlamorousCodeEditorAptitude;
		beReadOnlyWithSelection;
		background: Color white;
		margin: (BlInsets all: 5);
		vFitContent;
		hFitContent;
		text: self newIconCreationCode;
		constraintsDo: [ :c | 
			c linear vertical alignCenter ]
]

{ #category : #'instance creation' }
GtSpotterIconPreview >> newEditorAndClipboardElement [
	^ BrHorizontalPane new fitContent
		addChild: self newCodeEditor;
		addChild: self newClipboardElement;
		constraintsDo: [ :c | 
			c linear horizontal alignCenter ]
]

{ #category : #'instance creation' }
GtSpotterIconPreview >> newIconCreationCode [
	<return: #String>
	^ self iconLibrary asString , ' ' , self iconSelector asString
]

{ #category : #'instance creation' }
GtSpotterIconPreview >> newIconCreationCodeRope [
	<return: #BlRope>
	^ self newIconCreationCode asRopedText 
		attribute: (BrTextAdornmentDynamicAttribute new 
			beAppend;
			stencil: [ self newClipboardElement])
]

{ #category : #'instance creation' }
GtSpotterIconPreview >> printOn: aStream [
	self isDefined ifFalse: [ ^ super printOn: aStream ].
	aStream nextPutAll: self newIconCreationCode asString.
]
