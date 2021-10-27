Class {
	#name : #GtSpotterElement,
	#superclass : #BlElement,
	#instVars : [
		'spotterModel',
		'stepsPager',
		'results',
		'header',
		'preview'
	],
	#category : 'GToolkit-Spotter-UI'
}

{ #category : #'private - actions' }
GtSpotterElement >> actDueTo: anEventType [
	self
		spotterModelDo: [ :aSpotter | 
			aSpotter hasSteps
				ifFalse: [ ^ self ].
			aSpotter currentStep hasCandidates
				ifFalse: [ ^ self ].
			aSpotter currentStep actDueTo: anEventType from: self ]
]

{ #category : #initialization }
GtSpotterElement >> bindingDictionnary [
	^ {
	BlKeyCombination escape -> [ self exitDueTo: #keyPressedEscape ].
	BlKeyCombination primaryW -> [ self exitDueTo: #keyPressedW ].
	BlKeyCombination primaryP -> [ self togglePreview ].

	"(Character arrowUp -> [ self selectPreviousCandidateDueTo: #keyPressedArrowUp ])."
	"(Character arrowDown -> [ self selectNextCandidateDueTo: #keyPressedArrowDown ])."
	"(Character arrowUp meta -> [ self selectPreviousCandidateDueTo: #keyPressedArrowUp ]).
	(Character arrowDown meta -> [ self selectNextCandidateDueTo: #keyPressedArrowDown ]).
	(Character arrowUp shift -> [ self selectPreviousCandidateDueTo: #keyPressedArrowUp ]).
	(Character arrowDown shift -> [ self selectNextCandidateDueTo: #keyPressedArrowDown ]).
	(Character arrowUp meta shift -> [ self selectPreviousCategory ]).
	(Character arrowDown meta shift -> [ self selectNextCategory ])."

	(BlKeyCombination primaryArrowRight -> [ self diveInDueTo: #keyPressedPrimaryArrowRight ]).
	(BlKeyCombination primaryArrowLeft -> [ self diveOutDueTo: #keyPressedPrimaryArrowLeft ]).
	(BlKeyCombination arrowUp -> [ self selectPreviousCandidateDueTo: #keyPressedArrowUp ]).
	(BlKeyCombination arrowDown -> [ self selectNextCandidateDueTo: #keyPressedArrowDown ]).

	(BlKeyCombination primaryShiftArrowRight -> [ self diveInCategoryDueTo: #keyPressedShiftArrowRight ]).
	(BlKeyCombination primaryShiftArrowLeft -> [ self diveOutDueTo: #keyPressedShiftArrowLeft ]).

	"(Character arrowUp alt -> [ self stepScrollPageUp ]).
	(Character arrowDown alt -> [ self stepScrollPageDown ]).
	(Character pageUp -> [ self stepScrollPageUp ]).
	(Character pageDown -> [ self stepScrollPageDown ])."
	(BlKeyCombination return -> [ self actDueTo: #keyPressedReturn ]).
	"($p meta shift -> [ self exportAsPNGSilently ])"}
]

{ #category : #initialization }
GtSpotterElement >> createHeaderElement [
	^ GtSpotterHeaderElement new
]

{ #category : #initialization }
GtSpotterElement >> createPreviewElement [
	^ GtSpotterPreviewElement new
]

{ #category : #'private - actions' }
GtSpotterElement >> diveInCategoryDueTo: anEventType [

	self spotterModelDo: [ :aSpotter |
		aSpotter hasSelected
			ifTrue: [ aSpotter currentStep diveInCategoryDueTo: anEventType ] ]
]

{ #category : #'private - actions' }
GtSpotterElement >> diveInDueTo: anEventType [

	self spotterModelDo: [ :aSpotter |
		aSpotter hasSelected
			ifTrue: [ aSpotter currentStep diveInDueTo: anEventType ] ]
]

{ #category : #'private - actions' }
GtSpotterElement >> diveOutDueTo: anEventType [

	self spotterModelDo: [ :aSpotter |
		aSpotter hasSelected
			ifTrue: [ aSpotter currentStep diveOutDueTo: anEventType ] ]
]

{ #category : #'private - actions' }
GtSpotterElement >> exitDueTo: anEventType [
	self spotterModelDo: [ :aSpotter | aSpotter exitDueTo: anEventType ]
]

{ #category : #'private - accessing elements' }
GtSpotterElement >> header [
	^ header
]

{ #category : #initialization }
GtSpotterElement >> initialize [
	super initialize.

	self initializeSpotterElements.
	self initializeListeners.
	self addChild: (BrResizer new
			target: self;
			beBottom;
			aptitude: (BrGlamorousResizerAptitude new);
			when: BlResizerResizedEvent do: [ :anEvent | self fireEvent: GtSpotterResizedEvent new ];
			constraintsDo: [ :c |
				c ignoreByLayout.
				c ignored horizontal weight: 0.2 ]).
	self addChild: (BrResizer new
			target: self;
			beLeft;
			aptitude: BrGlamorousResizerAptitude;
			when: BlResizerResizedEvent do: [ :anEvent | self fireEvent: GtSpotterResizedEvent new ];
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored vertical weight: 0.2 ]).
	self addChild: (BrResizer new
			target: self;
			beRight;
			aptitude: BrGlamorousResizerAptitude;
			when: BlResizerResizedEvent do: [ :anEvent | self fireEvent: GtSpotterResizedEvent new ];
			constraintsDo: [ :c | 
				c ignoreByLayout.
				c ignored vertical weight: 0.2 ])
]

{ #category : #initialization }
GtSpotterElement >> initializeListeners [
	self bindingDictionnary
		associationsDo: [ :anAssociation |
			self addShortcut: (BlShortcutWithAction new combination: anAssociation key; action: anAssociation value).
			self searchField removeShortcutsWithCombination: anAssociation key ]
]

{ #category : #initialization }
GtSpotterElement >> initializeSpotterElements [
	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	self background: Color white.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	
	header := self createHeaderElement.
	
	results := BrPager new background: Color white.
	results aptitude: BrProportionalHorizontalPagerAptitude new.
	results hMatchParent; vMatchParent.

	stepsPager := GtSpotterPager new background: Color white.
	results addPage: (BlElement new
		viewModel: BrPagerPageModel new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: stepsPager).
		
	preview := self createPreviewElement.
	results addPage: preview.
	
	self addChildren: { header . results }.
]

{ #category : #'private - event handling' }
GtSpotterElement >> onAsyncCandidateSelected: anAnnouncement [
	self enqueueTask: (BlTaskAction new action: [
		self onCandidateSelected: anAnnouncement ])
]

{ #category : #'private - event handling' }
GtSpotterElement >> onCandidateSelected: anAnnouncement [
	self phlow selectObject: anAnnouncement selected item
]

{ #category : #'private - event handling' }
GtSpotterElement >> onCloseSpotter [
	"Check if I am opened in a separate window, then close that window otherwise just remove me from the space"
	(self isAttachedToSceneGraph
		and: [ self space root == self ])
			ifTrue: [ self space close ]
			ifFalse: [ self removeFromParent ]
]

{ #category : #'private - event handling' }
GtSpotterElement >> onHidePreview [
	results removePage: preview
]

{ #category : #'private - event handling' }
GtSpotterElement >> onShowPreview [
	results addPage: preview
]

{ #category : #'private - accessing elements' }
GtSpotterElement >> searchField [
	^ self header searchField
]

{ #category : #'private - actions' }
GtSpotterElement >> selectNextCandidateDueTo: anEventType [

	self spotterModelDo: [ :aSpotter |
		(aSpotter hasSelected and: [ aSpotter hasCandidates ])
			ifTrue: [ 
				aSpotter currentStep selectNextDueTo: anEventType ] ]
]

{ #category : #'private - actions' }
GtSpotterElement >> selectPreviousCandidateDueTo: anEventType [

	self spotterModelDo: [ :aSpotter |
		aSpotter hasSelected
			ifTrue: [ aSpotter currentStep selectPreviousDueTo: anEventType ] ]
]

{ #category : #'api - accessing' }
GtSpotterElement >> spotterModel: aSpotter [

	spotterModel := aSpotter.
	spotterModel attachedTo: self.
	
	header spotterModel: aSpotter.
	stepsPager spotterModel: aSpotter.
	preview spotterModel: aSpotter.
	
	aSpotter isPreviewVisible 
		ifTrue: [ self onShowPreview ]
		ifFalse: [ self onHidePreview ].
		
	spotterModel announcer when: GtSpotterExitAnnouncement send: #onCloseSpotter to: self.
	spotterModel announcer when: GtSpotterSelectedCandidateChanged send: #onAsyncCandidateSelected: to: self.
	spotterModel announcer when: GtSpotterShowPreview send: #onShowPreview to: self.
	spotterModel announcer when: GtSpotterHidePreview send: #onHidePreview to: self.
	
	aSpotter search
]

{ #category : #'private - accessing' }
GtSpotterElement >> spotterModelDo: aBlock [
	spotterModel ifNotNil: aBlock
]

{ #category : #'private - event handling' }
GtSpotterElement >> togglePreview [
	self spotterModelDo: [ :aSpotter | 
		aSpotter togglePreview ]
]
