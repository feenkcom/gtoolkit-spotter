Class {
	#name : #GtSpotterStepElement,
	#superclass : #BrColumnedTree,
	#instVars : [
		'stepModel'
	],
	#category : #'GToolkit-Spotter-UI-Bloc'
}

{ #category : #initialization }
GtSpotterStepElement >> initialize [
	super initialize.

	self rowStencil: (BrColumnedTreeRowStencilBuilder new
		cellSpacing: 2;
		indentation: 0;
		padding: (BlInsets left: 0)).

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
				ifEmpty: [
					| aCandidate |
					aCandidate := aNode value.
					
					BrLabel new
						look: (BrGlamorousLabelLook new);
						text: aNode value gtDisplayText;
						padding: (BlInsets all: 6);
						hMatchParent
					
				]
				ifNotEmpty: [
					| aCategory |
					
					aCategory := aNode value.
					
					BrLabel new
						look: (BrGlamorousLabelLook new foreground: Color gray; glamorousRegularSmallSize);
						text: '#', aCategory processor title;
						padding: (BlInsets top: 12 left: 6 bottom: 6 right: 6);
						hMatchParent
				].
			
			
			 ]
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

{ #category : #accessing }
GtSpotterStepElement >> stepModel: aSpotterStepModel [
	stepModel := aSpotterStepModel.
	
	stepModel candidates announcer weak
		subscribe: GtSpotterCandidateAdded send: #onCandidateAdded: to: self;
		subscribe: GtSpotterAllCandidatesAdded send: #onAllCandidatesAdded: to: self;
		subscribe: GtSpotterAllCandidatesRemoved send: #onAllCandidatesRemoved: to: self.

	self updateCandidates
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
