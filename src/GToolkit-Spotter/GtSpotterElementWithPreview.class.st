Class {
	#name : #GtSpotterElementWithPreview,
	#superclass : #GtSpotterElement,
	#instVars : [
		'previewObject',
		'previewTask',
		'previewElement',
		'labelElement'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #private }
GtSpotterElementWithPreview >> generatePreviewFor: anObject in: aPreviewContainer [

	| childElement |

	(anObject gtViewsFor: GtPhlowView empty) originalView asElementDo: [ :anElement |
		childElement := anElement ].

	self enqueueTask: (BlTaskAction new action: [
		previewObject = anObject ifTrue: [ 
			aPreviewContainer addChild: childElement.
			labelElement text: anObject gtDisplayText.
			previewElement visibility: BlVisibility visible. ] ]).
]

{ #category : #initialization }
GtSpotterElementWithPreview >> initialize [
	super initialize.
	
	previewElement := BlElement new.
	previewElement viewModel: BrPagerPageModel new.
	previewElement layout: BlLinearLayout vertical.
	previewElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	previewElement padding: (BlInsets all: 10).
	
	labelElement := BrLabel new
		look: (BrGlamorousLabelLook new foreground: Color gray);
		alignCenter;
		hMatchParent;
		vFitContent.
	
	previewElement addChild: labelElement.
	
	previewElement addChild: (BlElement new
		margin: (BlInsets all: 5);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ]) as: #previewContent.

	previewElement visibility: BlVisibility gone.
	
	results addPage: previewElement
]

{ #category : #'event - handling' }
GtSpotterElementWithPreview >> onCandidateDeselected [
	self onHidePreview
]

{ #category : #'event - handling' }
GtSpotterElementWithPreview >> onCandidateSelected: anAnnouncement [
	| anObject |
	super onCandidateSelected: anAnnouncement.
	
	anObject := anAnnouncement selected item.
	
	self updatePreview: anObject
]

{ #category : #'event - handling' }
GtSpotterElementWithPreview >> onCurrentStepChanged: anAnnouncement [

	self spotterModelDo: [ :aSpotter | aSpotter hasSelected
		ifTrue: [ self updatePreview: aSpotter currentStep selected item ]
		ifFalse: [ 
			self onHidePreview.
			previewObject := nil. ] ]
	
	
]

{ #category : #'event - handling' }
GtSpotterElementWithPreview >> onHidePreview [
	previewElement visibility: BlVisibility gone
]

{ #category : #'event - handling' }
GtSpotterElementWithPreview >> onShowPreview [

	self spotterModelDo: [ :aSpotterModel | aSpotterModel hasSelected
			ifFalse: [ ^ self ] ].

	previewElement visibility: BlVisibility visible.
	
]

{ #category : #accessing }
GtSpotterElementWithPreview >> spotterModel [
	^ spotterModel
]

{ #category : #accessing }
GtSpotterElementWithPreview >> spotterModel: aSpotterModel [
	super spotterModel: aSpotterModel.
	
	self when: GtPhlowObjectToSelect do: [ :anEvent | anEvent consumed: anEvent sourceElement == self ].

	spotterModel announcer when: GtSpotterCurrentStepChanged send: #onCurrentStepChanged: to: self.
	spotterModel announcer when: GtSpotterSearchFinished send: #onCurrentStepChanged: to: self.
	
	spotterModel class isPreviewVisible
		ifTrue: [ spotterModel showPreview ]
]

{ #category : #'event - handling' }
GtSpotterElementWithPreview >> updatePreview: anObject [
	| aPreviewContainer |

	anObject = previewObject ifTrue: [ ^self ].

	aPreviewContainer := previewElement
		childNamed: #previewContent
		ifFound: #yourself
		ifNone: [ previewElement ].
	aPreviewContainer removeChildren.

	previewObject := anObject.
	previewTask ifNotNil: [ previewTask terminate ].
	previewTask := [ self generatePreviewFor: anObject in: aPreviewContainer ]
		asBlTktTerminableCommand asBlTktLoggingCommand.
	previewTask name: 'Spotter update ', anObject gtDisplayText.
	BlTktWorkerProvider highUICPUBoundPool schedule: previewTask.

]
