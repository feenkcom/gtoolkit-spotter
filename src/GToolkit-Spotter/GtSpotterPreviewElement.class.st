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

{ #category : #private }
GtSpotterPreviewElement >> generatePreviewFor: aSpotterCandidate in: aPreviewContainer [

	| aChildElement aText |

	aChildElement := aSpotterCandidate previewElement.
	aChildElement ifNil: [ ^ self ].
	aText := aSpotterCandidate gtDisplayText.

	self enqueueTask: (BlTaskAction new action: [
		previewObject = aSpotterCandidate item ifTrue: [ 
			aPreviewContainer addChild: aChildElement.
			labelElement text: aText.
			self visibility: BlVisibility visible ] ]).
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

{ #category : #'event - handling' }
GtSpotterPreviewElement >> onCandidateSelected: anAnnouncement [
	self updatePreview: anAnnouncement selected
]

{ #category : #'event - handling' }
GtSpotterPreviewElement >> onCurrentStepChanged: anAnnouncement [

	self spotterModelDo: [ :aSpotter | aSpotter hasSelected
		ifTrue: [ self updatePreview: aSpotter currentStep selected ]
		ifFalse: [ 
			self onHidePreview.
			previewObject := nil. ] ]
]

{ #category : #'event - handling' }
GtSpotterPreviewElement >> onHidePreview [
	self visibility: BlVisibility gone
]

{ #category : #'event - handling' }
GtSpotterPreviewElement >> onShowPreview [

	self spotterModel hasSelected
			ifFalse: [ ^ self ].

	self visibility: BlVisibility visible.
	
]

{ #category : #accessing }
GtSpotterPreviewElement >> spotterModel [
	^ spotterModel
]

{ #category : #accessing }
GtSpotterPreviewElement >> spotterModel: aSpotterModel [
	spotterModel := aSpotterModel.
	self when: GtPhlowObjectToSelect do: [ :anEvent | anEvent consumed: anEvent sourceElement == self ].

	spotterModel announcer when: GtSpotterCurrentStepChanged send: #onCurrentStepChanged: to: self.
	spotterModel announcer when: GtSpotterSearchFinished send: #onCurrentStepChanged: to: self.
	spotterModel announcer when: GtSpotterSelectedCandidateChanged send: #onCandidateSelected: to: self.
	
	spotterModel class isPreviewVisible
		ifTrue: [ spotterModel showPreview ]
]

{ #category : #enumerating }
GtSpotterPreviewElement >> spotterModelDo: aBlock [
	spotterModel ifNotNil: aBlock
]

{ #category : #'event - handling' }
GtSpotterPreviewElement >> updatePreview: aSpotterCandidate [
	| aPreviewContainer |

	previewObject = aSpotterCandidate item ifTrue: [ ^self ].

	aPreviewContainer := self
		childNamed: #previewContent
		ifFound: #yourself
		ifNone: [ self ].
	aPreviewContainer removeChildren.

	previewObject := aSpotterCandidate item.
	previewTask ifNotNil: [ :aTask | aTask terminate ].
	BlUseAsyncFeatures 
		ifEnabledDo: [
			previewTask := [ self generatePreviewFor: aSpotterCandidate in: aPreviewContainer ] 
				asBlTktTerminableCommand asBlTktLoggingCommand.
			previewTask name: 'Spotter update ', aSpotterCandidate item gtDisplayString.
	 		BlTktWorkerProvider highUICPUBoundPool schedule: previewTask ]
		otherwise: [ self generatePreviewFor: aSpotterCandidate in: aPreviewContainer ].
]
