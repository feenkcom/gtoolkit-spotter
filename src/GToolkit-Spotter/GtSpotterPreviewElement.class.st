Class {
	#name : #GtSpotterPreviewElement,
	#superclass : #BlElement,
	#instVars : [
		'spotterModel',
		'previewObject',
		'previewTask',
		'labelElement',
		'previewContainer'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #updating }
GtSpotterPreviewElement >> generatePreviewFor: aSpotterCandidate [
	| aChildElement aText |

	self signalPreviewStartFor: aSpotterCandidate.

	aChildElement := aSpotterCandidate previewElement ifNil: [ BlElement new size: 0@0 ].
	aText := aSpotterCandidate gtDisplayText.
	self signalPreviewReadyFor: aSpotterCandidate element: aChildElement text: aText.

	^ aText -> aChildElement
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
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
		alignCenter;
		hMatchParent;
		vFitContent.

	previewContainer := BlElement new
		margin: (BlInsets all: 5);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ].

	self addChild: labelElement.
	self addChild: previewContainer.
	self visibility: BlVisibility gone.

	self withAsyncFutureDo: [ :anAsyncElementFuture |
		anAsyncElementFuture executionConfiguration: (AsyncFutureExecutionConfiguration new customGroup: #Spotter; lowPriority).
		anAsyncElementFuture whenPending: [
			self visibility: BlVisibility visible.
			labelElement text: 'Rendering...'.
			previewContainer removeChildren ].
		anAsyncElementFuture whenSuccess: [ :aPreviewElement :aPreviewAssociation |
			self visibility: BlVisibility visible.
			previewContainer removeChildren.
			labelElement text: aPreviewAssociation key.
			previewContainer addChild: aPreviewAssociation value ].
		anAsyncElementFuture whenError: [ :aPreviewElement :anError |
			self visibility: BlVisibility visible.
			previewContainer removeChildren.
			previewContainer addChild: anError asDebuggableElement ] ]
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
	self visibility: BlVisibility gone
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
	self updatePreview: self spotterModel selected
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
]

{ #category : #'private - accessing' }
GtSpotterPreviewElement >> spotterModelDo: aBlock [
	self spotterModel ifNotNil: aBlock
]

{ #category : #private }
GtSpotterPreviewElement >> terminatePreviewTask [
	"Terminate the preview computation task"
]

{ #category : #updating }
GtSpotterPreviewElement >> updatePreview: aSpotterCandidate [
	previewObject = aSpotterCandidate item
		ifTrue: [ ^ self ].

	previewObject := aSpotterCandidate item.
	
	self spotterModelDo: [ :aSpotterModel |
		aSpotterModel isPreviewVisible
			ifTrue: [ self asyncFuture future: [ self generatePreviewFor: aSpotterCandidate ] asAsyncFuture ] ]
]
