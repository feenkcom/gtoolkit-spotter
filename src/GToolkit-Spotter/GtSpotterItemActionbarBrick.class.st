Class {
	#name : #GtSpotterItemActionbarBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'stepModel',
		'diveInButton',
		'actOnButton',
		'candidateLink'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #accessing }
GtSpotterItemActionbarBrick >> actOnButton [
	^ actOnButton
]

{ #category : #adding }
GtSpotterItemActionbarBrick >> addActActionButton [

	actOnButton := (self newActionButtonBrick
			icon: self themer spotterThemer iconAct;
			hintTitle: 'Default action';
			hintText: '<enter>';
			action: [ self owner beSelected. self stepModel actDueTo: #actionButton ];
			yourself).

	self addActionButton: actOnButton.
]

{ #category : #adding }
GtSpotterItemActionbarBrick >> addActionButton: anActionButton [

	self themer spotterThemer itemActionButtonStyleFor: anActionButton.
	self themer spotterThemer itemActionButtonWidgetStyleFor: anActionButton.
		
	self addBrickBack: anActionButton.

	self stepModel spotter isShiftPressed
		ifTrue: [ self themer spotterThemer hintRevealStyleFor: anActionButton ].
]

{ #category : #adding }
GtSpotterItemActionbarBrick >> addDiveInActionButton [
			
	(self stepModel canDiveIn: self candidate) ifTrue: [
		diveInButton := (self newActionButtonBrick
			icon: self themer spotterThemer iconDiveIn;
			hintTitle: 'Dive in';
			hintText: '<',OSPlatform current defaultModifier name asLowercase,'+right>';
			action: [ self owner beSelected. self stepModel diveInDueTo: #actionButton ];
			yourself).
		
		self addActionButton: diveInButton ]
]

{ #category : #accessing }
GtSpotterItemActionbarBrick >> candidate [

	^ self candidateLink value
]

{ #category : #accessing }
GtSpotterItemActionbarBrick >> candidateLink [
	^ candidateLink
]

{ #category : #accessing }
GtSpotterItemActionbarBrick >> candidateLink: anObject [
	candidateLink := anObject
]

{ #category : #accessing }
GtSpotterItemActionbarBrick >> diveInButton [
	^ diveInButton
]

{ #category : #testing }
GtSpotterItemActionbarBrick >> hasStepModel [
	^ stepModel isNotNil
]

{ #category : #'instance creation' }
GtSpotterItemActionbarBrick >> newActionButtonBrick [

	^ GLMHintableActionButtonBrick new
]

{ #category : #'event handling' }
GtSpotterItemActionbarBrick >> onHideHints [

	self visible ifFalse: [ ^ self ].
	self themer spotterThemer hintHideStyleFor: self diveInButton.
	self themer spotterThemer hintHideStyleFor: self actOnButton.
]

{ #category : #'event handling' }
GtSpotterItemActionbarBrick >> onRevealHints [

	self visible ifFalse: [ ^ self ].
	self themer spotterThemer hintRevealStyleFor: self diveInButton.
	self themer spotterThemer hintRevealStyleFor: self actOnButton
]

{ #category : #'brick-properties-events' }
GtSpotterItemActionbarBrick >> onThemerChanged [
	super onThemerChanged.
	
	self themer spotterThemer itemActionbarStyleFor: self.
	self subbricks do: [ :aBrick | self themer spotterThemer itemActionButtonWidgetStyleFor: aBrick ]
]

{ #category : #accessing }
GtSpotterItemActionbarBrick >> stepModel [
	^ stepModel
]

{ #category : #accessing }
GtSpotterItemActionbarBrick >> stepModel: anObject [
	stepModel := anObject.
	
	self stepModel spotter announcer when: GtSpotterRevealHints send: #onRevealHints to: self.
	self stepModel spotter announcer when: GtSpotterHideHints send: #onHideHints to: self.
	
	self
		addActActionButton;
		addDiveInActionButton
]

{ #category : #actions }
GtSpotterItemActionbarBrick >> toggleHints [

	self visible ifFalse: [ ^ self ].
	self stepModel spotter isShiftPressed
		ifTrue: [ self onRevealHints ]
		ifFalse: [ self onHideHints ]
]

{ #category : #actions }
GtSpotterItemActionbarBrick >> visible: aBoolean [
	super visible: aBoolean.
	
	self toggleHints
	
	
]
