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
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #actions }
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
	"(BlKeyCombination primaryP -> [ self togglePreview ])."

	"(Character arrowUp -> [ self selectPreviousCandidateDueTo: #keyPressedArrowUp ])."
	"(Character arrowDown -> [ self selectNextCandidateDueTo: #keyPressedArrowDown ])."
	"(Character arrowUp meta -> [ self selectPreviousCandidateDueTo: #keyPressedArrowUp ]).
	(Character arrowDown meta -> [ self selectNextCandidateDueTo: #keyPressedArrowDown ]).
	(Character arrowUp shift -> [ self selectPreviousCandidateDueTo: #keyPressedArrowUp ]).
	(Character arrowDown shift -> [ self selectNextCandidateDueTo: #keyPressedArrowDown ]).
	(Character arrowUp meta shift -> [ self selectPreviousCategory ]).
	(Character arrowDown meta shift -> [ self selectNextCategory ])."

	(BlKeyCombination primaryArrowRight -> [ self diveInDueTo: #keyPressed ]).
	(BlKeyCombination primaryArrowLeft -> [ self diveOutDueTo: #keyPressed ]).
	(BlKeyCombination arrowUp -> [ self selectPreviousCandidateDueTo: #keyPressedArrowUp ]).
	(BlKeyCombination arrowDown -> [ self selectNextCandidateDueTo: #keyPressedArrowDown ]).

	"(Character arrowRight meta shift -> [ self diveInCategoryDueTo: #keyPressed ]).
	(Character arrowLeft meta shift -> [ self diveOut ]).
	(Character arrowUp alt -> [ self stepScrollPageUp ]).
	(Character arrowDown alt -> [ self stepScrollPageDown ]).
	(Character pageUp -> [ self stepScrollPageUp ]).
	(Character pageDown -> [ self stepScrollPageDown ])."
	(BlKeyCombination return -> [ self actDueTo: #keyPressed ]).
	"($p meta shift -> [ self exportAsPNGSilently ])"}
]

{ #category : #initialization }
GtSpotterElement >> createHeaderElement [
	^ GtSpotterHeaderElement new
]

{ #category : #actions }
GtSpotterElement >> diveInDueTo: anEventType [

	self spotterModelDo: [ :aSpotter |
		aSpotter hasSelected
			ifTrue: [ aSpotter currentStep diveInDueTo: anEventType ] ]
]

{ #category : #actions }
GtSpotterElement >> diveOutDueTo: anEventType [

	self spotterModelDo: [ :aSpotter |
		aSpotter hasSelected
			ifTrue: [ aSpotter currentStep diveOutDueTo: anEventType ] ]
]

{ #category : #actions }
GtSpotterElement >> exitDueTo: anEventType [
	self spotterModelDo: [ :aSpotter | aSpotter exitDueTo: anEventType ]
]

{ #category : #'accessing - elements' }
GtSpotterElement >> header [
	^ header
]

{ #category : #initialization }
GtSpotterElement >> initialize [
	super initialize.

	self initializeSpotterElements.
	self initializeListeners
]

{ #category : #initialization }
GtSpotterElement >> initializeListeners [
	self bindingDictionnary
		associationsDo: [ :anAssociation |
			self addShortcut: (BlShortcut new combination: anAssociation key; action: anAssociation value).
			self searchField removeShortcutsWithCombination: anAssociation key ]
]

{ #category : #initialization }
GtSpotterElement >> initializeSpotterElements [
	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	self background: Color white.
	self geometry: (BlRectangle cornerRadius: 5).
	
	header := self createHeaderElement.
	
	results := BrPager new.
	results look: BrProportionalPagerLook new.
	results hMatchParent; vMatchParent.

	stepsPager := GtSpotterPager new.
	results addPage: (BlElement new
		viewModel: BrPagerPageModel new;
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ];
		addChild: stepsPager).
		
	preview := GtSpotterPreviewElement new.
	results addPage: preview.
	
	self addChildren: { header . results }.
]

{ #category : #'event - handling' }
GtSpotterElement >> onCandidateSelected: anAnnouncement [
	self phlow selectObject: anAnnouncement selected item
]

{ #category : #'event - handling' }
GtSpotterElement >> onCloseSpotter [
	"Check if I am opened in a separate window, then close that window otherwise just remove me from the space"
	(self isAttachedToSceneGraph
		and: [ self space root == self ])
			ifTrue: [ self space close ]
			ifFalse: [ self removeFromParent ]
]

{ #category : #'accessing - elements' }
GtSpotterElement >> searchField [
	^ self header searchField
]

{ #category : #actions }
GtSpotterElement >> selectNextCandidateDueTo: anEventType [

	self spotterModelDo: [ :aSpotter |
		aSpotter hasSelected
			ifTrue: [ aSpotter currentStep selectNextDueTo: anEventType ] ]
]

{ #category : #actions }
GtSpotterElement >> selectPreviousCandidateDueTo: anEventType [

	self spotterModelDo: [ :aSpotter |
		aSpotter hasSelected
			ifTrue: [ aSpotter currentStep selectPreviousDueTo: anEventType ] ]
]

{ #category : #accessing }
GtSpotterElement >> spotterModel: aSpotter [

	spotterModel := aSpotter.
	spotterModel attachedTo: self.
	
	header spotterModel: aSpotter.
	stepsPager spotterModel: aSpotter.
	preview spotterModel: aSpotter.
	
	spotterModel announcer when: GtSpotterExitAnnouncement send: #onCloseSpotter to: self.
	spotterModel announcer when: GtSpotterSelectedCandidateChanged send: #onCandidateSelected: to: self.
	
	aSpotter search
]

{ #category : #accessing }
GtSpotterElement >> spotterModelDo: aBlock [
	spotterModel ifNotNil: aBlock
]
