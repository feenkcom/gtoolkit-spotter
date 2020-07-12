Class {
	#name : #GtSpotterStepElement,
	#superclass : #BrColumnedTree,
	#instVars : [
		'stepModel'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #'building widgets' }
GtSpotterStepElement >> buildCandidatesElementFor: aCandidate [
	^ BrLabel new
		look: (BrGlamorousLabelLook new);
		text: aCandidate gtDisplayText;
		padding: (BlInsets all: 6);
		hMatchParent
]

{ #category : #'building widgets' }
GtSpotterStepElement >> buildCategoryElementFor: aCategory [
	^ BrLabel new
		look: (BrGlamorousLabelLook new foreground: Color gray; glamorousRegularSmallSize);
		text: '#', aCategory processor title;
		padding: (BlInsets top: 12 left: 6 bottom: 6 right: 6);
		hMatchParent
]

{ #category : #initialization }
GtSpotterStepElement >> initialize [
	super initialize.

	self when: BrSelectionChanged do: [ :anEvent |
		self selectedNodeDo: [ :aTreeNode |
			self stepModelDo: [ :aSpotterStep |
				aTreeNode value children ifEmpty: [
					| aCandidate |
					aCandidate := aTreeNode value.
					aSpotterStep select: aCandidate dueTo: #singleClick ] ] ] ].

	self column
		title: 'Item';
		stencil: [ :aNode :index |
			aNode value children
				ifEmpty: [ self buildCandidatesElementFor: aNode value ]
				ifNotEmpty: [ self buildCategoryElementFor: aNode value ] ].

	self removeShortcutsWithCombination: BlKeyCombination arrowDown.
	self removeShortcutsWithCombination: BlKeyCombination arrowUp.
	self removeShortcutsWithCombination: BlKeyCombination arrowLeft.
	self removeShortcutsWithCombination: BlKeyCombination arrowRight.
]

{ #category : #'event handling' }
GtSpotterStepElement >> onAllCandidatesAdded: anAnnouncement [
	self updateCandidates
]

{ #category : #'event handling' }
GtSpotterStepElement >> onAllCandidatesRemoved: anAnnouncement [
	self updateCandidates
]

{ #category : #'event handling' }
GtSpotterStepElement >> onCandidateAdded: anAnnouncement [
	self updateCandidates
]

{ #category : #'event handling' }
GtSpotterStepElement >> onCandidateSelected: anAnnouncement [	
	self updateSelection
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
