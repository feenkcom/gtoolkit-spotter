Class {
	#name : #GtSpotterPreviewElement,
	#superclass : #BlElement,
	#instVars : [
		'spotterModel',
		'previewObject',
		'previewTask',
		'labelElement'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #updating }
GtSpotterPreviewElement >> generatePreviewFor: aSpotterCandidate in: aPreviewContainer [

	| aChildElement aText |
	self signalPreviewStartFor: aSpotterCandidate.
	aChildElement := aSpotterCandidate previewElement.
	aChildElement ifNil: [ ^ self ].
	aText := aSpotterCandidate gtDisplayText.
	self signalPreviewReadyFor: aSpotterCandidate element: aChildElement text: aText.

	self enqueueTask: (BlTaskAction new action: [
		previewObject = aSpotterCandidate item 
			ifTrue: [ 
				aPreviewContainer addChild: aChildElement.
				labelElement text: aText.
				self visibility: BlVisibility visible.
				self signalPreviewFinishedFor: aSpotterCandidate ]
			ifFalse: [ 
				self signalPreviewCanceledFor: aSpotterCandidate dueTo: previewObject ] ]).
]

{ #category : #initialization }
GtSpotterPreviewElement >> initialize [
	super initialize.
	
	self viewModel: BrPagerPageModel new.
	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	self padding: (BlInsets all: 10).
	
	labelElement := BrLabel new
		look: (BrGlamorousLabelLook new foreground: Color gray);
		alignCenter;
		hMatchParent;
		vFitContent.
	
	self addChild: labelElement.
	self addChild: (BlElement new
		margin: (BlInsets all: 5);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ]) as: #previewContent.
	self visibility: BlVisibility gone.
]

{ #category : #'private - event handling' }
GtSpotterPreviewElement >> onActOn: anAnnouncement [ 
	self terminatePreviewTask
]

{ #category : #'private - event handling' }
GtSpotterPreviewElement >> onAsyncCandidateSelected: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [
		self onCandidateSelected: anAnnouncement ])
]

{ #category : #'private - event handling' }
GtSpotterPreviewElement >> onCandidateSelected: anAnnouncement [
	self updatePreview: anAnnouncement selected
]

{ #category : #'private - event handling' }
GtSpotterPreviewElement >> onCurrentStepChanged: anAnnouncement [

	self spotterModelDo: [ :aSpotter | aSpotter hasSelected
		ifTrue: [ self updatePreview: aSpotter currentStep selected ]
		ifFalse: [ 
			self onHidePreview.
			previewObject := nil. ] ]
]

{ #category : #'private - event handling' }
GtSpotterPreviewElement >> onExit: anAnnouncement [ 
	self terminatePreviewTask
]

{ #category : #'private - event handling' }
GtSpotterPreviewElement >> onHidePreview [
	self visibility: BlVisibility gone.
]

{ #category : #'hooks - children' }
GtSpotterPreviewElement >> onRemovedFromSceneGraph [
	super onRemovedFromSceneGraph.
	self terminatePreviewTask.
]

{ #category : #'private - event handling' }
GtSpotterPreviewElement >> onShowPreview [

	self spotterModel hasSelected
			ifFalse: [ ^ self ].

	self visibility: BlVisibility visible.
	
]

{ #category : #signaling }
GtSpotterPreviewElement >> signalPreviewCanceledFor: anOriginalSpotterCandidate dueTo: aNewSpotterCandidate [
	self spotterModelDo: [ :aSpotter | 
		GtSpotterPreviewCanceledSignal new
			context: aSpotter currentStep context;
			candidate: anOriginalSpotterCandidate;
			newCandidate: aNewSpotterCandidate;
			emit ]
]

{ #category : #signaling }
GtSpotterPreviewElement >> signalPreviewFinishedFor: aSpotterCandidate [
	self spotterModelDo: [ :aSpotter | 
		GtSpotterPreviewFinishedSignal new
			context: aSpotter currentStep context;
			candidate: aSpotterCandidate;
			emit ]
]

{ #category : #signaling }
GtSpotterPreviewElement >> signalPreviewPreparationFor: aSpotterCandidate [
	self spotterModelDo: [ :aSpotter | 
		GtSpotterPreviewPreparationSignal new
			context: aSpotter currentStep context;
			candidate: aSpotterCandidate;
			emit ]
]

{ #category : #signaling }
GtSpotterPreviewElement >> signalPreviewReadyFor: aSpotterCandidate element: aChildElement text: aText [
	self spotterModelDo: [ :aSpotter | 
		GtSpotterPreviewReadySignal new
			context: aSpotter currentStep context;
			candidate: aSpotterCandidate;
			previewElement: aChildElement;
			text: aText;
			emit ]
]

{ #category : #signaling }
GtSpotterPreviewElement >> signalPreviewStartFor: aSpotterCandidate [
	self spotterModelDo: [ :aSpotter | 
		GtSpotterPreviewStartSignal new
			context: aSpotter currentStep context;
			candidate: aSpotterCandidate;
			emit ]
]

{ #category : #'private - accessing' }
GtSpotterPreviewElement >> spotterModel [
	^ spotterModel
]

{ #category : #'api - accessing' }
GtSpotterPreviewElement >> spotterModel: aSpotterModel [
	spotterModel := aSpotterModel.
	self when: GtPhlowObjectToSelect do: [ :anEvent | anEvent consumed: anEvent sourceElement == self ].

	spotterModel announcer when: GtSpotterCurrentStepChanged send: #onCurrentStepChanged: to: self.
	spotterModel announcer when: GtSpotterSearchFinished send: #onCurrentStepChanged: to: self.
	spotterModel announcer when: GtSpotterSelectedCandidateChanged send: #onAsyncCandidateSelected: to: self.
	spotterModel announcer when: GtSpotterExitAnnouncement send: #onExit: to: self.
	spotterModel announcer when: GtSpotterActOn send: #onActOn: to: self.
	
	spotterModel class isPreviewVisible
		ifTrue: [ spotterModel showPreview ]
]

{ #category : #'private - accessing' }
GtSpotterPreviewElement >> spotterModelDo: aBlock [
	self spotterModel ifNotNil: aBlock
]

{ #category : #private }
GtSpotterPreviewElement >> terminatePreviewTask [
	previewTask ifNotNil: [ :aTask | aTask terminate ]
]

{ #category : #updating }
GtSpotterPreviewElement >> updatePreview: aSpotterCandidate [
	| aPreviewContainer |
	previewObject = aSpotterCandidate item
		ifTrue: [ ^ self ].
	aPreviewContainer := self
		childNamed: #previewContent
		ifFound: #yourself
		ifNone: [ self ].
	aPreviewContainer removeChildren.
	previewObject := aSpotterCandidate item.
	self terminatePreviewTask.
	BlUseAsyncFeatures
		ifEnabledDo: [ 
			self signalPreviewPreparationFor: aSpotterCandidate.
			previewTask := [ 
				self
					generatePreviewFor: aSpotterCandidate
					in: aPreviewContainer ] 
						asBlTktTerminableCommand asBlTktLoggingCommand.
			previewTask
				name: 'Spotter update ' , aSpotterCandidate item gtDisplayString.
			BlTktWorkerProvider highUICPUBoundPool schedule: previewTask ]
		otherwise: [ self generatePreviewFor: aSpotterCandidate in: aPreviewContainer ]
]
