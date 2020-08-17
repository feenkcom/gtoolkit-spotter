Class {
	#name : #GtSpotterCandidateElement,
	#superclass : #GtSpotterStepItemElement,
	#instVars : [
		'candidate',
		'label',
		'actOnButton',
		'diveInButton'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #'private - actions' }
GtSpotterCandidateElement >> actDueTo: anEventType [

	self stepModelDo: [ :aStepModel |
		aStepModel actOn: self candidate dueTo: anEventType from: self ]
]

{ #category : #'api - accessing' }
GtSpotterCandidateElement >> bindData: anObject [
	"Bind data to this element"
	self 
		assert: [ anObject class = GtSpotterCandidate ] 
		description: [ 'I can bind only ', GtSpotterCandidate name, ' instances' ].
	self candidate: anObject
]

{ #category : #'private - accessing' }
GtSpotterCandidateElement >> candidate [
	<return: #GtSpotterCandidate>
	^ candidate
]

{ #category : #'api - accessing' }
GtSpotterCandidateElement >> candidate: aCandidate [
	self candidate == aCandidate ifTrue: [ ^ self ].
	self 
		assert: [ aCandidate isNotNil ] 
		description: [ 'Candidate must be non-nil' ].
	candidate := aCandidate.
	self onCandidateChanged.
]

{ #category : #'private - accessing' }
GtSpotterCandidateElement >> candidateDo: aBlock [
	self candidate ifNotNil: aBlock
]

{ #category : #'private - actions' }
GtSpotterCandidateElement >> diveInDueTo: anEventType [

	self stepModelDo: [ :aStepModel |
		aStepModel diveIn: self candidate dueTo: anEventType ]
]

{ #category : #'private - actions' }
GtSpotterCandidateElement >> hideActions [
	actOnButton visibility: BlVisibility hidden.
	diveInButton visibility: BlVisibility hidden.
]

{ #category : #initialization }
GtSpotterCandidateElement >> initialize [
	super initialize.
	self initializeLabel.
	self initializeActOnButton.
	self initializeDiveInButton.
	self
		when: BlDoubleClickEvent
		do: [ :anEvent | self actDueTo: #buttonClick ].
	self hMatchParent.
	self vFitContent.
	self cellSpacing: 5.
	self padding: (BlInsets top: 5 bottom: 5).
	self addChild: label as: #label.
	self addChild: actOnButton as: #actButton.
	self addChild: diveInButton as: #diveInButton.
]

{ #category : #initialization }
GtSpotterCandidateElement >> initializeActOnButton [
	actOnButton := BrButton new
		look: BrGlamorousButtonWithIconLook;
		icon: BrGlamorousVectorIcons accept;
		label: 'Select Item';
		action: [ self actDueTo: #buttonClick ];
		visibility: BlVisibility hidden;
		beTiny;
		fitContent;
		alignCenterLeft.
]

{ #category : #initialization }
GtSpotterCandidateElement >> initializeDiveInButton [
	diveInButton := BrButton new
		look: BrGlamorousButtonWithIconLook;
		icon: BrGlamorousIcons right;
		label: 'Dive-In to Search Item Details';
		action: [ self diveInDueTo: #buttonClick ];
		visibility: BlVisibility hidden;
		beTiny;
		fitContent;
		alignCenterLeft.
]

{ #category : #initialization }
GtSpotterCandidateElement >> initializeLabel [
	label := BrLabel new
		look: (BrGlamorousLabelLook new);
		hMatchParent;
		vFitContent;
		alignCenterLeft.
]

{ #category : #'private - testing' }
GtSpotterCandidateElement >> isCandidateSelected [
	self stepModelDo: [ :aModel |
		self candidateDo: [ :aCandidate | 
			^ aModel isSelected: aCandidate ] ].
	^ false
]

{ #category : #'private - actions' }
GtSpotterCandidateElement >> mayHideActions [
	self isCandidateSelected ifTrue: [ ^ self ].
	self isMouseHovering ifTrue: [ ^ self ].
	self hideActions.
]

{ #category : #'private - hooks' }
GtSpotterCandidateElement >> onCandidateChanged [
	self updateLabel.
	self updateActions.
]

{ #category : #'private - event handling' }
GtSpotterCandidateElement >> onCandidateSelected: aGtSpotterSelectedCandidateChanged [
	super onCandidateSelected: aGtSpotterSelectedCandidateChanged.
	(aGtSpotterSelectedCandidateChanged selected = self candidate)
		ifTrue: [ self showActions ]
		ifFalse: [ self mayHideActions ]
]

{ #category : #'private - event handling' }
GtSpotterCandidateElement >> onMouseEnter [
	super onMouseEnter.
	self showActions.
]

{ #category : #'private - event handling' }
GtSpotterCandidateElement >> onMouseLeave [
	super onMouseLeave.
	self mayHideActions.
]

{ #category : #'private - actions' }
GtSpotterCandidateElement >> showActions [
	actOnButton visibility: BlVisibility visible.
	diveInButton visibility: BlVisibility visible.
]

{ #category : #'private - updating' }
GtSpotterCandidateElement >> updateActions [
	self isCandidateSelected
		ifTrue: [ self showActions ]
		ifFalse: [ self hideActions ]
]

{ #category : #'private - updating' }
GtSpotterCandidateElement >> updateLabel [
	label text: self candidate gtDisplayText
]
