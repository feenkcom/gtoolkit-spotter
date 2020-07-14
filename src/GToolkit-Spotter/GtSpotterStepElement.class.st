Class {
	#name : #GtSpotterStepElement,
	#superclass : #BrColumnedTree,
	#instVars : [
		'stepModel',
		'showWhenSelectedOrHovered'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #'private - actions' }
GtSpotterStepElement >> actDueTo: anEventType [

	self stepModelDo: [ :aStepModel |
		aStepModel actDueTo: anEventType from: self ]
]

{ #category : #'private - building widgets' }
GtSpotterStepElement >> buildCandidateElementFor: aCandidate [
	| aLabel anActOnButton aDiveInButton |
	aLabel := BrLabel new
		look: (BrGlamorousLabelLook new);
		text: aCandidate gtDisplayText;
		hMatchParent;
		vFitContent;
		alignCenterLeft.
	
	anActOnButton := BrButton new
		look: BrGlamorousButtonWithIconLook;
		icon: BrGlamorousVectorIcons accept;
		label: 'Select Item';
		action: [ self actDueTo: #buttonClick ];
		visibility: BlVisibility hidden;
		beSmall;
		fitContent;
		alignCenterRight.
	
	aDiveInButton := BrButton new
		look: BrGlamorousButtonWithIconLook;
		icon: BrGlamorousIcons right;
		label: 'Dive-In to Search Item Details';
		action: [ self diveInDueTo: #buttonClick ];
		visibility: BlVisibility hidden;
		beSmall;
		fitContent;
		alignCenterRight.
	
	(self isCandidateSelected: aCandidate) ifFalse: [ 
		aDiveInButton visibility: BlVisibility hidden ].
	
	^ BrHorizontalPane new
		labeled: 'Candidate';
		in: [ :thePane | self make: anActOnButton in: thePane visibleWhenCandidateHovered: aCandidate ];
		in: [ :thePane | self make: aDiveInButton in: thePane visibleWhenCandidateHovered: aCandidate ];
		cellSpacing: 5;
		hMatchParent;
		vFitContent;
		padding: (BlInsets all: 6);
		addChild: aLabel as: #label;
		addChild: anActOnButton as: #actButton;
		addChild: aDiveInButton as: #diveInButton.
]

{ #category : #'private - building widgets' }
GtSpotterStepElement >> buildCategoryElementFor: aCategory [
	| aLabel aDiveInButton |
	aLabel := BrLabel new
		look: (BrGlamorousLabelLook new foreground: Color gray; glamorousRegularSmallSize);
		text: '#', aCategory processor title;
		fitContent;
		alignCenterLeft.
	
	aDiveInButton := BrButton new
		look: BrGlamorousButtonWithIconLook;
		icon: BrGlamorousIcons right;
		label: 'Dive-In Category to Refine Search Results';
		action: [ self diveInCategoryDueTo: #buttonClick ];
		beSmall;
		fitContent;
		alignCenterLeft.
		
	^ BrHorizontalPane new
		labeled: 'Category';
		cellSpacing: 5;
		hMatchParent;
		vFitContent;
		padding: (BlInsets top: 12 left: 6 bottom: 6 right: 6);
		addChild: aLabel as: #label;
		addChild: aDiveInButton as: #button.
]

{ #category : #'private - actions' }
GtSpotterStepElement >> diveInCategoryDueTo: anEventType [

	self stepModelDo: [ :aStepModel |
		aStepModel diveInCategoryDueTo: anEventType ]
]

{ #category : #'private - actions' }
GtSpotterStepElement >> diveInDueTo: anEventType [

	self stepModelDo: [ :aStepModel |
		aStepModel diveInDueTo: anEventType ]
]

{ #category : #initialization }
GtSpotterStepElement >> initialize [
	super initialize.

	showWhenSelectedOrHovered := OrderedCollection new: 2.

	self when: BrSelectionChanged do: [ :anEvent |
		self onItemSelectionChanged: anEvent ].

	self column
		title: 'Item';
		stencil: [ :aNode :anIndex |
			aNode value children
				ifEmpty: [ self buildCandidateElementFor: aNode value ]
				ifNotEmpty: [ self buildCategoryElementFor: aNode value ] ].

	self removeShortcutsWithCombination: BlKeyCombination arrowDown.
	self removeShortcutsWithCombination: BlKeyCombination arrowUp.
	self removeShortcutsWithCombination: BlKeyCombination arrowLeft.
	self removeShortcutsWithCombination: BlKeyCombination arrowRight.
]

{ #category : #'private - testing' }
GtSpotterStepElement >> isCandidateSelected: aCandidate [
	self stepModelDo: [ :aModel |
		^ aModel isSelected: aCandidate ].
	^ false
]

{ #category : #'private - building widgets' }
GtSpotterStepElement >> make: aButton in: aPane visibleWhenCandidateHovered: aCandidate [
	aPane
		when: BlMouseEnterEvent
		do: [ :anEvent | aButton visibility: BlVisibility visible ].
	aPane
		when: BlMouseLeaveEvent
		do: [ :anEvent | 
			(self isCandidateSelected: aCandidate) ifFalse: [ 
				aButton visibility: BlVisibility hidden ] ].
]

{ #category : #'private - event handling' }
GtSpotterStepElement >> onAllCandidatesAdded: anAnnouncement [
	self updateCandidates
]

{ #category : #'private - event handling' }
GtSpotterStepElement >> onAllCandidatesRemoved: anAnnouncement [
	self updateCandidates
]

{ #category : #'private - event handling' }
GtSpotterStepElement >> onCandidateAdded: anAnnouncement [
	self updateCandidates
]

{ #category : #'private - event handling' }
GtSpotterStepElement >> onCandidateSelected: anAnnouncement [	
	self updateSelection
]

{ #category : #'private - event handling' }
GtSpotterStepElement >> onItemSelectionChanged: anEvent [
	self selectedNodeDo: [ :aTreeNode |
		self stepModelDo: [ :aSpotterStep |
			aTreeNode value children ifEmpty: [
				| aCandidate |
				aCandidate := aTreeNode value.
				aSpotterStep select: aCandidate dueTo: #singleClick ] ] ]
]

{ #category : #accessing }
GtSpotterStepElement >> stepModel: aSpotterStepModel [
	stepModel := aSpotterStepModel.
	stepModel candidates announcer 
		when: GtSpotterCandidateAdded send: #onCandidateAdded: to: self;
		when: GtSpotterAllCandidatesAdded
			send: #onAllCandidatesAdded:
			to: self;
		when: GtSpotterAllCandidatesRemoved
			send: #onAllCandidatesRemoved:
			to: self.
	stepModel announcer 
		when: GtSpotterSelectedCandidateChanged
		send: #onCandidateSelected:
		to: self.
	self updateCandidates.
	self updateSelection
]

{ #category : #accessing }
GtSpotterStepElement >> stepModelDo: aBlock [
	stepModel ifNotNil: aBlock
]

{ #category : #private }
GtSpotterStepElement >> updateCandidates [

	self stepModelDo: [ :aSpotterStep |
		self
			items: aSpotterStep candidates children children: #children;
			expandAll ]
]

{ #category : #private }
GtSpotterStepElement >> updateSelection [

	self stepModelDo: [ :aSpotterStep |		
		aSpotterStep hasSelected
			ifTrue: [ self selectOne: (aSpotterStep candidates treeIndexOf: aSpotterStep selected) ] ]
]
