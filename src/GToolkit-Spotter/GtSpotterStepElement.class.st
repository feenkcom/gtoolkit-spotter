Class {
	#name : #GtSpotterStepElement,
	#superclass : #BrColumnedTree,
	#instVars : [
		'stepModel',
		'showWhenSelectedOrHovered'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #'private - building widgets' }
GtSpotterStepElement >> buildCandidateElementFor: aCandidate [
	^ GtSpotterCandidateElement new 
			stepModel: self stepModel;
			candidate: aCandidate
]

{ #category : #'private - building widgets' }
GtSpotterStepElement >> buildCategoryElementFor: aCategory [
	^ GtSpotterCategoryElement new 
			stepModel: self stepModel;
			category: aCategory
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

{ #category : #'private - accessing' }
GtSpotterStepElement >> stepModel [
	^ stepModel
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

{ #category : #'private - accessing' }
GtSpotterStepElement >> stepModelDo: aBlock [
	self stepModel ifNotNil: aBlock
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
