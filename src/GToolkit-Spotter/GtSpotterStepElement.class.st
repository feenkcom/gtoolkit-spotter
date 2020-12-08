Class {
	#name : #GtSpotterStepElement,
	#superclass : #BrColumnedTree,
	#instVars : [
		'stepModel'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #'private - updating' }
GtSpotterStepElement >> asyncUpdateCandidates [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateCandidates ])
]

{ #category : #'private - updating' }
GtSpotterStepElement >> asyncUpdateSelection [
	self enqueueTask: (BlTaskAction new action: [ 
		self updateSelection ])
]

{ #category : #initialization }
GtSpotterStepElement >> initialize [
	super initialize.
	self
		when: BrSelectionChanged
		do: [ :anEvent | self onItemSelectionChanged: anEvent ].
	self initializeColumn.
	self removeShortcutsWithCombination: BlKeyCombination arrowDown.
	self removeShortcutsWithCombination: BlKeyCombination arrowUp.
	self removeShortcutsWithCombination: BlKeyCombination arrowLeft.
	self removeShortcutsWithCombination: BlKeyCombination arrowRight.
	self beInSeparateCompositionLayer
]

{ #category : #initialization }
GtSpotterStepElement >> initializeColumn [
	self rowStencil: BrGlamorousColumnedTreeSelectableRowElementStencilBuilder new.
	self nodeType: [ :anItemTypeFactory :aTreeNode :aNodeIndex | 
		aTreeNode value isCollection
			ifFalse: [ GtSpotterCandidateElement ] 
			ifTrue: [ GtSpotterCategoryElement ] ].

	self column
		title: 'Item';
		cellStencil: [ :anItemType :aBrColumn :aNodeIndex | 
			anItemType asElement stepModel: self stepModel ];
		dataBinder: [ :anItemElement :anItemObject :anItemIndex :aRowHolder :aColumnIndex |
			anItemElement bindData: anItemObject ].
]

{ #category : #'private - testing' }
GtSpotterStepElement >> isCandidateSelected: aCandidate [
	self stepModelDo: [ :aModel |
		^ aModel isSelected: aCandidate ].
	^ false
]

{ #category : #'private - event handling' }
GtSpotterStepElement >> onAsyncAllCandidatesAdded: anAnnouncement [
	self asyncUpdateCandidates
]

{ #category : #'private - event handling' }
GtSpotterStepElement >> onAsyncAllCandidatesRemoved: anAnnouncement [
	self asyncUpdateCandidates
]

{ #category : #'private - event handling' }
GtSpotterStepElement >> onAsyncCandidateAdded: anAnnouncement [
	self asyncUpdateCandidates
]

{ #category : #'private - event handling' }
GtSpotterStepElement >> onAsyncCandidateSelected: anAnnouncement [	
	self asyncUpdateSelection 
]

{ #category : #'private - event handling' }
GtSpotterStepElement >> onItemSelectionChanged: anEvent [
	"This ${class:BrSelectionChanged}$ event comes from the UI process"
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
	self unsubscribeFromStepModel.
	stepModel := aSpotterStepModel.
	self subscribeToStepModel.
	self updateCandidates.
	self updateSelection
]

{ #category : #'private - accessing' }
GtSpotterStepElement >> stepModelDo: aBlock [
	self stepModel ifNotNil: aBlock
]

{ #category : #'private - subscriptions' }
GtSpotterStepElement >> subscribeToStepModel [
	self stepModelDo: [ :aStepModel |
		aStepModel candidates announcer
			when: GtSpotterCandidateAdded send: #onAsyncCandidateAdded: to: self;
			when: GtSpotterAllCandidatesAdded
				send: #onAsyncAllCandidatesAdded:
				to: self;
			when: GtSpotterAllCandidatesRemoved
				send: #onAsyncAllCandidatesRemoved:
				to: self.
		aStepModel announcer
			when: GtSpotterSelectedCandidateChanged
			send: #onAsyncCandidateSelected:
			to: self ]
]

{ #category : #'private - subscriptions' }
GtSpotterStepElement >> unsubscribeFromStepModel [
	self stepModelDo: [ :aStepModel |
		aStepModel candidates announcer unsubscribe: self.
		aStepModel announcer unsubscribe: self ].
]

{ #category : #'private - updating' }
GtSpotterStepElement >> updateCandidates [
	self
		stepModelDo: [ :aSpotterStep | 
			self
				items: aSpotterStep candidates children lazy: #children;
				expandAll ]
]

{ #category : #'private - updating' }
GtSpotterStepElement >> updateSelection [

	self stepModelDo: [ :aSpotterStep |		
		aSpotterStep hasSelected
			ifTrue: [ self selectOne: (aSpotterStep candidates treeIndexOf: aSpotterStep selected) ] ]
]
