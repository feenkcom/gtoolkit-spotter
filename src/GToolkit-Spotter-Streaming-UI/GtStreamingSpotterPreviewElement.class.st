Class {
	#name : #GtStreamingSpotterPreviewElement,
	#superclass : #BrVerticalPane,
	#instVars : [
		'previewObject',
		'spotterSearch',
		'previewTask',
		'labelElement',
		'previewContainer'
	],
	#category : #'GToolkit-Spotter-Streaming-UI'
}

{ #category : #'private - preview' }
GtStreamingSpotterPreviewElement >> generatePreviewOf: anObject forSearch: aSpotterSearch [
	| aChildElement aText aPreviewObject |
	
	aPreviewObject := aSpotterSearch previewObjectFor: anObject.

	aChildElement := (aSpotterSearch previewElementFor: aPreviewObject) ifNil: [ BlElement new size: 0@0 ].
	aText := aPreviewObject gtDisplayText.

	^ aText -> aChildElement
]

{ #category : #initialization }
GtStreamingSpotterPreviewElement >> initialize [
	super initialize.

	self matchParent.
	self padding: (BlInsets all: 10).

	self when: GtPhlowObjectToSelect do: [ :anEvent | anEvent consumed: anEvent sourceElement == self ].

	labelElement := BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
		alignCenter;
		hMatchParent;
		vFitContent.

	previewContainer := BrFrame new
		margin: (BlInsets all: 5);
		matchParent.

	self addChildren: { labelElement. previewContainer }.

	self withAsyncFutureDo: [ :anAsyncElementFuture |
		anAsyncElementFuture
			executionConfiguration: (AsyncFutureExecutionConfiguration new customGroup: #Spotter; lowPriority);
			whenPending: [
				labelElement text: 'Rendering...'.
				previewContainer removeChildren ];
			whenSuccess: [ :aPreviewElement :aPreviewAssociation |
				previewContainer removeChildren.
				labelElement text: aPreviewAssociation key.
				previewContainer addChild: aPreviewAssociation value ];
			whenError: [ :aPreviewElement :anError |
				previewContainer removeChildren.
				previewContainer addChild: anError asDebuggableElement ] ]
]

{ #category : #'private - event handling' }
GtStreamingSpotterPreviewElement >> onActOn: anAnnouncement [ 
	self terminatePreviewTask
]

{ #category : #'private - event handling' }
GtStreamingSpotterPreviewElement >> onAsyncCandidateSelected: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [
		self onCandidateSelected: anAnnouncement ])
]

{ #category : #'private - event handling' }
GtStreamingSpotterPreviewElement >> onCandidateSelected: anAnnouncement [
	self updatePreview: anAnnouncement selected
]

{ #category : #'private - event handling' }
GtStreamingSpotterPreviewElement >> onCurrentStepChanged: anAnnouncement [

	self spotterModelDo: [ :aSpotter | aSpotter hasSelected
		ifTrue: [ self updatePreview: aSpotter currentStep selectedItem ]
		ifFalse: [ 
			self onHidePreview.
			previewObject := nil. ] ]
]

{ #category : #'private - event handling' }
GtStreamingSpotterPreviewElement >> onExit: anAnnouncement [ 
	self terminatePreviewTask
]

{ #category : #'private - preview' }
GtStreamingSpotterPreviewElement >> terminatePreviewTask [
	"Terminate the preview computation task"
]

{ #category : #initialization }
GtStreamingSpotterPreviewElement >> updatePreviewOf: anObject forSearch: aGtSpotterSearch [
	(previewObject = anObject
		and: [ spotterSearch = aGtSpotterSearch ])
		ifTrue: [ ^ self ].

	previewObject := anObject.
	spotterSearch := aGtSpotterSearch.
	self asyncFuture future: [ self generatePreviewOf: previewObject forSearch: spotterSearch ] asAsyncFuture
]
