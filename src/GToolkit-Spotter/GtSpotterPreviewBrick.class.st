Class {
	#name : #GtSpotterPreviewBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'compositeBrick',
		'spotterModel',
		'asyncTask',
		'previewObject'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #accessing }
GtSpotterPreviewBrick >> asyncTask [

	^ asyncTask ifNil: [ asyncTask := GLMAsyncTask new ]
]

{ #category : #accessing }
GtSpotterPreviewBrick >> compositeBrick [

	^ compositeBrick
]

{ #category : #accessing }
GtSpotterPreviewBrick >> compositeBrick: aBrick [

	self compositeBrick ifNotNil: [ self removeBrick: self compositeBrick ].
	compositeBrick := aBrick.
	self themer spotterThemer spotterPreviewCompositeStyleFor: self compositeBrick.
	self addBrickBack: self compositeBrick.
	self doLayoutForce
]

{ #category : #initialization }
GtSpotterPreviewBrick >> defaultNotAvailableText [

	^ 'Preview is not available :('
]

{ #category : #updating }
GtSpotterPreviewBrick >> handleException: exception forComposite: composite [ 

	('[Spotter] Exception while building the preview content: ', exception asString) logCr.
	composite removeAllBricks.
]

{ #category : #initialization }
GtSpotterPreviewBrick >> initialize [
	super initialize.
	
	self compositeBrick: self newCompositeBrick
]

{ #category : #'instance creation' }
GtSpotterPreviewBrick >> newCompositeBrick [

	^ GLMCompositeBrick new
]

{ #category : #'event handling' }
GtSpotterPreviewBrick >> onCandidateSelected: ann [

	self updatePreviewWith: ann selected
]

{ #category : #'event handling' }
GtSpotterPreviewBrick >> onSearchFinished [

	self spotterModel currentStep candidates isEmpty
		ifTrue: [ self updatePreviewWithEmpty ]
]

{ #category : #'event handling' }
GtSpotterPreviewBrick >> onStepAdded [

	previewObject := nil.
	self updatePreviewWithLoading
]

{ #category : #'event handling' }
GtSpotterPreviewBrick >> onStepPopped [

	self updatePreviewWith: self spotterModel steps last selected candidate
]

{ #category : #accessing }
GtSpotterPreviewBrick >> onThemerChanged [
	super onThemerChanged.
	
	self themer spotterThemer spotterPreviewWidgetStyleFor: self
]

{ #category : #accessing }
GtSpotterPreviewBrick >> spotterModel [

	^ spotterModel
]

{ #category : #accessing }
GtSpotterPreviewBrick >> spotterModel: aSpotter [
	
	spotterModel := aSpotter.
	aSpotter announcer when: GtSpotterSelectedCandidateChanged send: #onCandidateSelected: to: self.
	aSpotter announcer when: GtSpotterStepRemoved send: #onStepPopped to: self.
	aSpotter announcer when: GtSpotterStepAdded send: #onStepAdded to: self.
	aSpotter announcer when: GtSpotterSearchFinished send: #onSearchFinished to: self.
	
	
]

{ #category : #updating }
GtSpotterPreviewBrick >> updatePreviewWith: anObject [
	|wasNil|
	self spotterModel isPreviewVisible ifFalse: [ ^ self ].
	
	wasNil := previewObject isNil.
	previewObject = anObject ifTrue: [ ^ self ].
	previewObject := anObject.
	previewObject ifNil: [ ^ self updatePreviewWithEmpty ].
	wasNil ifTrue: [ self updatePreviewWithLoading ].
	
	self asyncTask
		execute: [ :composite :entity |
				[ entity spotterPreviewIn: composite inContext: self spotterModel ]
					on: Error
					do: [ :exception |
						self spotterModel exceptionHandler 
							handleException: exception 
							do: [ self handleException: exception forComposite: composite ] ].
				 composite ]
		withArguments: { self newCompositeBrick . anObject }
		callback: [ :composite |
			self compositeBrick: composite.
			self changed ]
		priority: Processor userBackgroundPriority
		delay: 50
]

{ #category : #updating }
GtSpotterPreviewBrick >> updatePreviewWithEmpty [

	self removeAllBricks.
	self asyncTask
		execute: [ | emptyBrick |
			emptyBrick := GLMLabelBrick new
				text: self defaultNotAvailableText;
				textPosition: #center;
				textColor: Color lightGray;
					with: [ :b | b label
					customFont;
					fontSize: 14 ] ]
		withArguments: {  }
		callback: [ :brick | self compositeBrick: brick ]
		priority: Processor userBackgroundPriority
		delay: 50
]

{ #category : #updating }
GtSpotterPreviewBrick >> updatePreviewWithLoading [

	self compositeBrick: (
		GLMLabelBrick new
			text: 'Loading...';
			textPosition: #center;
			textColor: Color lightGray;
				with: [ :b | b label
				customFont;
				fontSize: 14 ])
]
