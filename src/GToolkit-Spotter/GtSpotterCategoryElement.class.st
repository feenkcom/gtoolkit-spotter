Class {
	#name : #GtSpotterCategoryElement,
	#superclass : #GtSpotterStepItemElement,
	#instVars : [
		'category',
		'diveInButton',
		'amountElement',
		'labelElement',
		'actOnButton'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #'private - actions' }
GtSpotterCategoryElement >> actDueTo: anEventType [

	self stepModelDo: [ :aStepModel |
		aStepModel actOnCategory: self category dueTo: anEventType from: self ]
]

{ #category : #'api - accessing' }
GtSpotterCategoryElement >> bindData: anObject [
	"Bind data to this element"
	self 
		assert: [ anObject class = GtSpotterProcessorCandidates ] 
		description: [ 'I can bind only ', GtSpotterProcessorCandidates name, ' instances' ].
	self category: anObject
]

{ #category : #'private - accessing' }
GtSpotterCategoryElement >> category [
	<return: #GtSpotterProcessorCandidates>
	^ category
]

{ #category : #'api - accessing' }
GtSpotterCategoryElement >> category: aGtSpotterProcessorCandidates [
	self category == aGtSpotterProcessorCandidates ifTrue: [ ^ self ].
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
		aStepModel diveInCategory: self processor dueTo: anEventType ]
]

{ #category : #'private - actions' }
GtSpotterCategoryElement >> hideActions [
	actOnButton visibility: BlVisibility hidden.
	diveInButton visibility: BlVisibility hidden.
]

{ #category : #initialization }
GtSpotterCategoryElement >> initialize [
	super initialize.
	self initializeLabel.
	self initializeAmountElement.
	self initializeActOnButton.
	self initializeDiveInButton.
	self hMatchParent.
	self vFitContent.
	self cellSpacing: 5.
	self padding: (BlInsets top: 12 left: 6 bottom: 6 right: 6).
	self addChild: labelElement as: #label.
	self addChild: amountElement as: #amount.
	self addChild: actOnButton as: #actOnButton.
	self addChild: diveInButton as: #diveInButton.
]

{ #category : #initialization }
GtSpotterCategoryElement >> initializeActOnButton [
	actOnButton := BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons accept;
		label: 'Select Category Items';
		action: [ self actDueTo: #buttonClick ];
		visibility: BlVisibility hidden;
		beTinySize;
		fitContent;
		alignCenterLeft
]

{ #category : #initialization }
GtSpotterCategoryElement >> initializeAmountElement [
	amountElement := GtSpotterAmountElement new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray; glamorousRegularSmallSize);
		hFitContent;
		vFitContent;
		alignCenterLeft
]

{ #category : #initialization }
GtSpotterCategoryElement >> initializeDiveInButton [
	diveInButton := BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons right;
		label: 'Dive-In Category to Refine Search Results';
		visibility: BlVisibility hidden;
		action: [ self diveInCategoryDueTo: #buttonClick ];
		beTinySize;
		fitContent;
		alignCenterLeft
]

{ #category : #initialization }
GtSpotterCategoryElement >> initializeLabel [
	labelElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray; glamorousRegularSmallSize);
		hFitContent;
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

{ #category : #'private - accessing' }
GtSpotterCategoryElement >> numberOfVisibleChildren [
	<return: #Integer>
	self categoryDo: [ :aCategory | ^ aCategory size ].
	^ 0
]

{ #category : #'private - event handling' }
GtSpotterCategoryElement >> onAsyncCandidatesAmountChanged: aGtSpotterCandidatesAmountChanged [
	
	| aProcessor anAmount |
	aProcessor := aGtSpotterCandidatesAmountChanged category.
	anAmount := aGtSpotterCandidatesAmountChanged amount.
	
	self enqueueTask: (BlTaskAction new action: [ 
		self onProcessor: aProcessor candidatesAmountChangedTo: anAmount ]).
]

{ #category : #'private - event handling' }
GtSpotterCategoryElement >> onCandidateSelected: aGtSpotterSelectedCandidateChanged [
	super onCandidateSelected: aGtSpotterSelectedCandidateChanged.
	(aGtSpotterSelectedCandidateChanged selected processor = self processor)
		ifTrue: [ self showActions ]
		ifFalse: [ self mayHideActions ]
]

{ #category : #'private - hooks' }
GtSpotterCategoryElement >> onCategoryChanged [
	self updateLabel.
	self updateVisibleAndTotalAmount.
	self updateActions
]

{ #category : #'private - event handling' }
GtSpotterCategoryElement >> onMouseEnter [
	super onMouseEnter.
	self showActions.
]

{ #category : #'private - event handling' }
GtSpotterCategoryElement >> onMouseLeave [
	super onMouseLeave.
	self mayHideActions.
]

{ #category : #'private - event handling' }
GtSpotterCategoryElement >> onProcessor: aProcessor candidatesAmountChangedTo: anAmount [

	aProcessor = self processor ifFalse: [ ^ self ].
	
	self updateTotalAmount: anAmount.
]

{ #category : #'private - accessing' }
GtSpotterCategoryElement >> processor [
	<return: #GtSpotterProcessorCandidates>
	^ self category processor
]

{ #category : #'private - actions' }
GtSpotterCategoryElement >> showActions [
	actOnButton visibility: BlVisibility visible.
	diveInButton visibility: BlVisibility visible.
]

{ #category : #'private - subscriptions' }
GtSpotterCategoryElement >> subscribeToSpotterStep [
	super subscribeToSpotterStep.
	self stepModel candidates announcer
		when: GtSpotterCandidatesAmountChanged
		send: #onAsyncCandidatesAmountChanged:
		to: self.
]

{ #category : #'private - updating' }
GtSpotterCategoryElement >> updateActions [
	self isCategorySelected
		ifTrue: [ self showActions ]
		ifFalse: [ self hideActions ]
]

{ #category : #'private - updating' }
GtSpotterCategoryElement >> updateLabel [
	labelElement text: '#' , self category processor title asString
]

{ #category : #'private - updating' }
GtSpotterCategoryElement >> updateTotalAmount: anInteger [ 
	amountElement total: anInteger
]

{ #category : #'private - updating' }
GtSpotterCategoryElement >> updateVisibleAmount: anInteger [ 
	amountElement visible: anInteger
]

{ #category : #'private - updating' }
GtSpotterCategoryElement >> updateVisibleAndTotalAmount [
	self updateVisibleAmount: self numberOfVisibleChildren.
	self processor allFilteredCandidatesDo: [ :aCollection | 
		self updateTotalAmount: aCollection size ]
]
