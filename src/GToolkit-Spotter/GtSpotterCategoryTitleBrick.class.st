Class {
	#name : #GtSpotterCategoryTitleBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'nameBrick',
		'amountBrick',
		'actionbarBrick',
		'stepModel',
		'diveInButton',
		'shortcutBrick',
		'category'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #accessing }
GtSpotterCategoryTitleBrick >> actionbarBrick [
	^ actionbarBrick
]

{ #category : #accessing }
GtSpotterCategoryTitleBrick >> actionbarBrick: anObject [
	actionbarBrick := anObject.

	self actionbarBrick
		vSpaceFill;
		hShrinkWrap.
]

{ #category : #adding }
GtSpotterCategoryTitleBrick >> addDiveInButton [
	
	diveInButton := self newActionbarButton.
	self diveInButton
		icon: self themer spotterThemer iconDiveInCategory;
		pressedColor: (self themer spotterThemer itemActionSelectedBackgroundColor alpha: 0.5);
		action: [ self stepModel diveInCategory: self category dueTo: #actionButton ];
		beHelp;
		hintTitle: 'Show all';
		hintText: '<',OSPlatform current defaultModifier name asLowercase,'+shift+right>'.
		
	self pushActionButton: self diveInButton
	
]

{ #category : #accessing }
GtSpotterCategoryTitleBrick >> amountBrick [

	^ amountBrick
]

{ #category : #accessing }
GtSpotterCategoryTitleBrick >> amountBrick: aBrick [

	amountBrick ifNotNil: [self removeBrick: amountBrick].
	amountBrick := aBrick.
	
	self themer spotterThemer categoryAmountStyleFor: amountBrick.
	
	self addBrickBack: amountBrick
]

{ #category : #accessing }
GtSpotterCategoryTitleBrick >> category [
	self assert: category isNotNil.
	^ category
]

{ #category : #accessing }
GtSpotterCategoryTitleBrick >> category: aProcessor [
	self assert: aProcessor isNotNil.
	category := aProcessor
]

{ #category : #accessing }
GtSpotterCategoryTitleBrick >> diveInButton [
	^ diveInButton
]

{ #category : #actions }
GtSpotterCategoryTitleBrick >> hideActionbar [

	(self hasSubbrick: self actionbarBrick) ifTrue: [ 
		self removeBrick: self actionbarBrick ]
]

{ #category : #initialization }
GtSpotterCategoryTitleBrick >> initialize [
	super initialize.
	self enable.
	self announcer when: #onMouseHover send: #onHovered to: self.
	self announcer when: #onMouseUnhover send: #onUnhovered to: self
]

{ #category : #accessing }
GtSpotterCategoryTitleBrick >> nameBrick [

	^ nameBrick
]

{ #category : #accessing }
GtSpotterCategoryTitleBrick >> nameBrick: aBrick [

	nameBrick ifNotNil: [self removeBrick: nameBrick].
	nameBrick := aBrick.
	
	self themer spotterThemer categoryTitleNameStyleFor: nameBrick.
	
	self addBrickBack: nameBrick
]

{ #category : #'instance creation' }
GtSpotterCategoryTitleBrick >> newActionbarBrick [

	^ GLMBrick new
]

{ #category : #'instance creation' }
GtSpotterCategoryTitleBrick >> newActionbarButton [

	^ GLMHintableActionButtonBrick new
]

{ #category : #'instance creation' }
GtSpotterCategoryTitleBrick >> newAmountBrick [

	^ GLMLabelBrick new
]

{ #category : #'instance creation' }
GtSpotterCategoryTitleBrick >> newNameBrick [

	^ GLMLabelBrick new
]

{ #category : #'instance creation' }
GtSpotterCategoryTitleBrick >> newShortcutBrick [

	^ GLMLabelBrick new
]

{ #category : #'instance creation' }
GtSpotterCategoryTitleBrick >> on: aStepModel category: aProcessor [

	self stepModel: aStepModel.
	self category: aProcessor.
	
	self nameBrick: self newNameBrick.
	self nameBrick text: '#', aProcessor title.
	
	aProcessor keyBinding ifNotNil: [ 
		self shortcutBrick: self newShortcutBrick.
		self setShortcutBrickTextFor: aProcessor ].
			
	self amountBrick: self newAmountBrick.
	self amountBrick text: '0/0'.
	
	self actionbarBrick: self newActionbarBrick.
	self addDiveInButton.
	
	self onCandidateSelected.
	
	self nameBrick wrappedBounds markWidthDirty.
	self nameBrick label wrappedBounds markWidthDirty.
	self doLayoutForce.

	^ self
]

{ #category : #'event-handling' }
GtSpotterCategoryTitleBrick >> onCandidateSelected [
	
	(self stepModel isCategorySelected: self category)
		ifTrue: [ self showActionbar ]
		ifFalse: [
			"well, we need to check first if there are not hovered candidates for my category"
			(self isSelected not and: [
				self owner isNotNil and: [
					(self owner owner categories includesKey: self category) and: [ 
						(self owner owner categoryBrickOf: self category) isSelected not  ] ] ] )
			ifTrue: [ self hideActionbar ] ]
]

{ #category : #'event-handling' }
GtSpotterCategoryTitleBrick >> onHideHints [

	(self hasSubbrick: self actionbarBrick) ifFalse: [ ^ self ].
	self themer spotterThemer hintHideStyleFor: self diveInButton
]

{ #category : #'event-handling' }
GtSpotterCategoryTitleBrick >> onHovered [
	self showActionbar
]

{ #category : #layouting }
GtSpotterCategoryTitleBrick >> onLayoutEvent: aLayoutEvent [
	super onLayoutEvent: aLayoutEvent.
	
	(aLayoutEvent isKindOf: GLMBrickLayoutStacked) ifTrue: [ "self enable" ]
]

{ #category : #'event-handling' }
GtSpotterCategoryTitleBrick >> onRevealHints [

	(self hasSubbrick: self actionbarBrick) ifFalse: [ ^ self ].
	self themer spotterThemer hintRevealStyleFor: self diveInButton
]

{ #category : #'brick-properties-events' }
GtSpotterCategoryTitleBrick >> onThemerChanged [
	super onThemerChanged.
	
	self themer spotterThemer categoryTitleWidgetStyleFor: self.
	self themer spotterThemer categoryAmountWidgetStyleFor: self amountBrick.
	self themer spotterThemer categoryTitleNameWidgetStyleFor: self nameBrick.
]

{ #category : #'event-handling' }
GtSpotterCategoryTitleBrick >> onUnhovered [
	(self stepModel isCategorySelected: self category)
		ifFalse: [ self hideActionbar ]
]

{ #category : #adding }
GtSpotterCategoryTitleBrick >> pushActionButton: aButton [

	aButton
		width: [ :b | b icon width * 1.5 ];
		vSpaceFill.
		
	self actionbarBrick addBrickBack: aButton.
	
	self stepModel spotter isShiftPressed
		ifTrue: [ self themer spotterThemer hintRevealStyleFor: aButton ]
]

{ #category : #accessing }
GtSpotterCategoryTitleBrick >> setAmountVisible: visible all: all [

	self amountBrick text: (visible asString, '/', all asString).
	self amountBrick wrappedBounds markWidthDirty.
	self amountBrick doLayout.
	self doLayoutForce
]

{ #category : #'instance creation' }
GtSpotterCategoryTitleBrick >> setShortcutBrickTextFor: aProcessor [
	
	self shortcutBrick text: (ToggleMenuItemShortcut 
		owner: nil 
		keyText: 
			(aProcessor keyBinding printString 
				copyReplaceAll: 'Meta' 
				with: OSPlatform current defaultModifier name)) text
]

{ #category : #accessing }
GtSpotterCategoryTitleBrick >> shortcutBrick [

	^ shortcutBrick
]

{ #category : #accessing }
GtSpotterCategoryTitleBrick >> shortcutBrick: aBrick [

	shortcutBrick ifNotNil: [self removeBrick: shortcutBrick].
	shortcutBrick := aBrick.
	
	self themer spotterThemer categoryTitleShortcutStyleFor: shortcutBrick.
	
	self addBrickBack: shortcutBrick
]

{ #category : #actions }
GtSpotterCategoryTitleBrick >> showActionbar [

	(self hasSubbrick: self actionbarBrick) ifFalse: [ 
		self addBrickBack: self actionbarBrick.
		self toggleHints ]
]

{ #category : #accessing }
GtSpotterCategoryTitleBrick >> stepModel [

	^ stepModel
]

{ #category : #accessing }
GtSpotterCategoryTitleBrick >> stepModel: anObject [
	stepModel := anObject.
	
	self stepModel announcer when: GTSpotterSelectedCandidateChanged send: #onCandidateSelected to: self.
	self stepModel spotter announcer when: GTSpotterRevealHints send: #onRevealHints to: self.
	self stepModel spotter announcer when: GTSpotterHideHints send: #onHideHints to: self
]

{ #category : #actions }
GtSpotterCategoryTitleBrick >> toggleHints [

	(self hasSubbrick: self actionbarBrick) ifFalse: [ ^ self ].
	self stepModel spotter isShiftPressed
		ifTrue: [ self onRevealHints ]
		ifFalse: [ self onHideHints ]
]
