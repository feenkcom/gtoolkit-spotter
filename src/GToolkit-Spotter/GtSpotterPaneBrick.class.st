Class {
	#name : #GtSpotterPaneBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'contentsBrick',
		'previewBrick',
		'arrowBrick'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #accessing }
GtSpotterPaneBrick >> arrowBrick [

	^ arrowBrick
]

{ #category : #accessing }
GtSpotterPaneBrick >> arrowBrick: aBrick [

	arrowBrick := aBrick.
	self themer spotterThemer spotterPreviewArrowContainerStyleFor: self arrowBrick.
	self addBrickBack: self arrowBrick
]

{ #category : #accessing }
GtSpotterPaneBrick >> contentsBrick [

	^ contentsBrick
]

{ #category : #accessing }
GtSpotterPaneBrick >> contentsBrick: aBrick [
	
	contentsBrick ifNotNil: [self removeBrick: contentsBrick].
	contentsBrick := aBrick.
		
	self themer spotterThemer spotterContentsStyleFor: contentsBrick.

	self addBrickBack: contentsBrick
]

{ #category : #action }
GtSpotterPaneBrick >> hidePreview [

	self isPreviewShown ifFalse: [ ^ self ].

	self removeBrick: self previewBrick.
	self contentsBrick layout hSpaceFill.
	self changed.
]

{ #category : #initialization }
GtSpotterPaneBrick >> initialize [
	super initialize.
	
	self contentsBrick: self newContentsBrick.
	self arrowBrick: self newArrowBrick.
	self previewBrick: self newPreviewBrick
]

{ #category : #testing }
GtSpotterPaneBrick >> isPreviewShown [

	^ self hasSubbrick: self previewBrick
]

{ #category : #'instance creation' }
GtSpotterPaneBrick >> newArrowBrick [

	^ GtSpotterPreviewArrowBrick new
]

{ #category : #'instance creation' }
GtSpotterPaneBrick >> newContentsBrick [

	^ GtSpotterContentsBrick new
]

{ #category : #'instance creation' }
GtSpotterPaneBrick >> newPreviewBrick [

	^ GtSpotterPreviewBrick new
]

{ #category : #accessing }
GtSpotterPaneBrick >> previewBrick [

	^ previewBrick
]

{ #category : #accessing }
GtSpotterPaneBrick >> previewBrick: aBrick [

	previewBrick ifNotNil: [self removeBrick: aBrick].
	previewBrick := aBrick.
	
	self themer spotterThemer spotterPreviewStyleFor: previewBrick
]

{ #category : #action }
GtSpotterPaneBrick >> showPreview [
	
	self isPreviewShown ifTrue: [ ^ self ].
	
	self addBrickBack: self previewBrick.
	self previewBrick spotterModel ifNotNil: [ :aSpotter |
		aSpotter hasSelected ifTrue: [
			self previewBrick updatePreviewWith: aSpotter currentStep selected candidate ] ].
	
	self contentsBrick hSpaceFill: (100 - self previewBrick layout hPercent).
	self changed.
]

{ #category : #accessing }
GtSpotterPaneBrick >> spotterModel: aSpotter [

	self contentsBrick spotterModel: aSpotter.
	self arrowBrick spotterModel: aSpotter.
	self previewBrick spotterModel: aSpotter
]
