Class {
	#name : #GtSpotterCategoryElement,
	#superclass : #GtSpotterStepItemElement,
	#instVars : [
		'category',
		'label',
		'diveInButton'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #'private - accessing' }
GtSpotterCategoryElement >> category [
	<return: #GtSpotterProcessorCandidates>
	^ category
]

{ #category : #'api - accessing' }
GtSpotterCategoryElement >> category: aGtSpotterProcessorCandidates [
	self 
		assert: [ aGtSpotterProcessorCandidates isNotNil ] 
		description: [ 'Candidate must be non-nil' ].
	category := aGtSpotterProcessorCandidates.
	self onCategoryChanged.
]

{ #category : #'private - accessing' }
GtSpotterCategoryElement >> categoryDo: aBlock [
	self category ifNotNil: aBlock
]

{ #category : #'private - actions' }
GtSpotterCategoryElement >> diveInCategoryDueTo: anEventType [

	self stepModelDo: [ :aStepModel |
		aStepModel diveInCategoryDueTo: anEventType ]
]

{ #category : #'private - actions' }
GtSpotterCategoryElement >> hideActions [
	diveInButton visibility: BlVisibility hidden.
]

{ #category : #initialization }
GtSpotterCategoryElement >> initialize [
	super initialize.
	self initializeLabel.
	self initializeDiveInButton.
	self hMatchParent.
	self vFitContent.
	self cellSpacing: 5.
	self padding: (BlInsets top: 12 left: 6 bottom: 6 right: 6).
	self addChild: label as: #label.
	self addChild: diveInButton as: #diveInButton.
]

{ #category : #initialization }
GtSpotterCategoryElement >> initializeDiveInButton [
	diveInButton := BrButton new
		look: BrGlamorousButtonWithIconLook;
		icon: BrGlamorousIcons right;
		label: 'Dive-In Category to Refine Search Results';
		visibility: BlVisibility hidden;
		action: [ self diveInCategoryDueTo: #buttonClick ];
		beTiny;
		fitContent;
		alignCenterLeft.
]

{ #category : #initialization }
GtSpotterCategoryElement >> initializeLabel [
	label := BrLabel new
		look: (BrGlamorousLabelLook new foreground: Color gray; glamorousRegularSmallSize);
		hMatchParent;
		vFitContent;
		alignCenterLeft
]

{ #category : #'private - testing' }
GtSpotterCategoryElement >> isCategorySelected [
	self stepModelDo: [ :aModel |
		^ aModel isCategorySelected: self category processor ].
	^ false
]

{ #category : #'private - actions' }
GtSpotterCategoryElement >> mayHideActions [
	self isCategorySelected ifTrue: [ ^ self ].
	self isMouseHovering ifTrue: [ ^ self ].
	self hideActions.
]

{ #category : #'private - hooks' }
GtSpotterCategoryElement >> onCandidateSelected: aGtSpotterSelectedCandidateChanged [
	super onCandidateSelected: aGtSpotterSelectedCandidateChanged.
	(aGtSpotterSelectedCandidateChanged selected processor = self category processor)
		ifTrue: [ self showActions ]
		ifFalse: [ self mayHideActions ]
]

{ #category : #'private - hooks' }
GtSpotterCategoryElement >> onCategoryChanged [
	label text: '#', self category processor title asString.
	self isCategorySelected 
		ifTrue: [ self showActions ]
		ifFalse: [ self hideActions ].
]

{ #category : #'private - hooks' }
GtSpotterCategoryElement >> onMouseEnter [
	super onMouseEnter.
	self showActions.
]

{ #category : #'private - hooks' }
GtSpotterCategoryElement >> onMouseLeave [
	super onMouseLeave.
	self mayHideActions.
]

{ #category : #'private - actions' }
GtSpotterCategoryElement >> showActions [
	diveInButton visibility: BlVisibility visible.
]
