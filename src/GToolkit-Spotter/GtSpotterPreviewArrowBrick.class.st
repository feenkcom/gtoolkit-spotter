Class {
	#name : #GtSpotterPreviewArrowBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'triangleBrick',
		'selectedItemBrick',
		'spotterModel',
		'isTriangleVisible'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #actions }
GtSpotterPreviewArrowBrick >> hideTriangle [

	isTriangleVisible := false.
	self themer spotterThemer spotterPreviewArrowWidgetStyleFor: self triangleBrick.
	self changed
]

{ #category : #initialization }
GtSpotterPreviewArrowBrick >> initialize [
	super initialize.
	
	self triangleBrick: self newTriangleBrick
]

{ #category : #testing }
GtSpotterPreviewArrowBrick >> isTriangleVisible [

	^ isTriangleVisible ifNil: [ isTriangleVisible := false ]
]

{ #category : #actions }
GtSpotterPreviewArrowBrick >> moveTo: anItemBrick [
	|itemBounds delta selfBounds|
	anItemBrick ifNil: [ ^ self ].
	
	itemBounds := anItemBrick globalBounds.
	selfBounds := self globalBounds.
	
	delta := ((itemBounds top - selfBounds top) max: 0) min: (selfBounds height - self triangleBrick height).
	self triangleBrick brickBounds top = delta ifTrue: [ ^ self ].
	
	self triangleBrick marginTop: delta.
	self triangleBrick doLayoutForce.
	self owner changed
	
]

{ #category : #'instance creation' }
GtSpotterPreviewArrowBrick >> newTriangleBrick [

	^ GLMHintableActionButtonBrick new
]

{ #category : #'event handling' }
GtSpotterPreviewArrowBrick >> onAllCandidatesRemoved [

	self selectedItemBrick: nil
]

{ #category : #'event handling' }
GtSpotterPreviewArrowBrick >> onCandidateMoved [

	self moveTo: self selectedItemBrick
]

{ #category : #'event handling' }
GtSpotterPreviewArrowBrick >> onCandidateSelected: ann [

	self selectedItemBrick: ann itemBrick.
	self moveTo: self selectedItemBrick
]

{ #category : #'brick-drawing' }
GtSpotterPreviewArrowBrick >> onDraw: aCanvas [
	super onDraw: aCanvas.
	
		aCanvas
			fillRectangle: ((self brickBounds withWidth: self themer spotterThemer outerBorderWidth) translateBy: (self themer scrollbarWidth + self themer scrollbarOffset + 1)@0)
			color: (self spotterModel isPreviewVisible
				ifTrue: [ self themer spotterThemer backgroundColor ]
				ifFalse: [ Color transparent ])
	
	
]

{ #category : #'event handling' }
GtSpotterPreviewArrowBrick >> onHideHints [

	self themer spotterThemer hintHideArrowStyleFor: self triangleBrick
]

{ #category : #'event handling' }
GtSpotterPreviewArrowBrick >> onHidePreview [

	self triangleBrick renderer border: self themer spotterThemer outerBorderWidth.
	self triangleBrick selectedColor: Color transparent.
	self changed
]

{ #category : #'event handling' }
GtSpotterPreviewArrowBrick >> onRevealHints [

	self themer spotterThemer hintRevealArrowStyleFor: self triangleBrick
]

{ #category : #'event handling' }
GtSpotterPreviewArrowBrick >> onShowPreview [

	self triangleBrick renderer border: 0.
	self triangleBrick selectedColor: self themer spotterThemer borderColor.
	self changed
]

{ #category : #'event handling' }
GtSpotterPreviewArrowBrick >> onStepAdded [
	
	self selectedItemBrick: nil.
	self spotterModel steps last candidates announcer when: GTSpotterAllCandidatesRemoved send: #onAllCandidatesRemoved to: self.
]

{ #category : #'brick-properties-events' }
GtSpotterPreviewArrowBrick >> onThemerChanged [
	super onThemerChanged.
	
	self themer spotterThemer spotterPreviewArrowWidgetStyleFor: self triangleBrick
]

{ #category : #accessing }
GtSpotterPreviewArrowBrick >> selectedItemBrick [
	
	^ selectedItemBrick
]

{ #category : #accessing }
GtSpotterPreviewArrowBrick >> selectedItemBrick: aBrick [
	
	selectedItemBrick isNil & aBrick isNotNil ifTrue: [ self showTriangle ].
	selectedItemBrick isNotNil & aBrick isNil ifTrue: [ self hideTriangle ].
	
	selectedItemBrick := aBrick
]

{ #category : #actions }
GtSpotterPreviewArrowBrick >> showTriangle [

	isTriangleVisible := true.
	self themer spotterThemer spotterPreviewArrowWidgetStyleFor: self triangleBrick.
	self changed
]

{ #category : #accessing }
GtSpotterPreviewArrowBrick >> spotterModel [

	^ spotterModel
]

{ #category : #accessing }
GtSpotterPreviewArrowBrick >> spotterModel: aSpotterModel [

	spotterModel := aSpotterModel.
	
	self spotterModel announcer when: GTSpotterCandidateSelected send: #onCandidateSelected: to: self.
	self spotterModel announcer when: GTSpotterCandidateSelectedMoved send: #onCandidateMoved to: self.
	self spotterModel announcer when: GTSpotterStepAdded send: #onStepAdded to: self.
	self spotterModel announcer when: GTSpotterShowPreview send: #onShowPreview to: self.
	self spotterModel announcer when: GTSpotterHidePreview send: #onHidePreview to: self.
	
	self spotterModel announcer when: GTSpotterRevealHints send: #onRevealHints to: self.
	self spotterModel announcer when: GTSpotterHideHints send: #onHideHints to: self.
]

{ #category : #accessing }
GtSpotterPreviewArrowBrick >> triangleBrick [

	^ triangleBrick
]

{ #category : #accessing }
GtSpotterPreviewArrowBrick >> triangleBrick: aBrick [

	triangleBrick := aBrick.
	self triangleBrick
		hintTitle: 'Toggle preview';
		hintText: '<',OSPlatform current defaultModifier name asLowercase,'+p>';
		action: [ self spotterModel togglePreview ].
	self themer spotterThemer spotterPreviewArrowStyleFor: self triangleBrick.
	self addBrickBack: self triangleBrick
	
]
