Class {
	#name : #GtSpotterElement,
	#superclass : #BlElement,
	#instVars : [
		'spotterModel',
		'searchField',
		'stepsPager',
		'breadcrumb'
	],
	#category : #'GToolkit-Spotter-UI-Bloc'
}

{ #category : #initialization }
GtSpotterElement >> bindingDictionnary [
	^ {
	BlKeyCombination escape -> [ self exitDueTo: #keyPressedEscape ].
	BlKeyCombination primaryW -> [ self exitDueTo: #keyPressedW ].
	"(BlKeyCombination primaryP -> [ self togglePreview ])."

	"(Character arrowUp -> [ self selectPreviousCandidateDueTo: #keyPressedArrowUp ]).
	(Character arrowDown -> [ self selectNextCandidateDueTo: #keyPressedArrowDown ]).
	(Character arrowUp meta -> [ self selectPreviousCandidateDueTo: #keyPressedArrowUp ]).
	(Character arrowDown meta -> [ self selectNextCandidateDueTo: #keyPressedArrowDown ]).
	(Character arrowUp shift -> [ self selectPreviousCandidateDueTo: #keyPressedArrowUp ]).
	(Character arrowDown shift -> [ self selectNextCandidateDueTo: #keyPressedArrowDown ]).
	(Character arrowUp meta shift -> [ self selectPreviousCategory ]).
	(Character arrowDown meta shift -> [ self selectNextCategory ])."

	(BlKeyCombination primaryArrowRight -> [ self diveInDueTo: #keyPressed ]).
	(BlKeyCombination primaryArrowLeft -> [ self diveOutDueTo: #keyPressed ]).
	(BlKeyCombination arrowLeft -> [ self ]).
	(BlKeyCombination arrowRight -> [ self ]).
	(BlKeyCombination arrowUp -> [ self ]).
	(BlKeyCombination arrowDown -> [ self ]).

	"(Character arrowRight meta shift -> [ self diveInCategoryDueTo: #keyPressed ]).
	(Character arrowLeft meta shift -> [ self diveOut ]).
	(Character arrowUp alt -> [ self stepScrollPageUp ]).
	(Character arrowDown alt -> [ self stepScrollPageDown ]).
	(Character pageUp -> [ self stepScrollPageUp ]).
	(Character pageDown -> [ self stepScrollPageDown ]).
	(Character cr asKeyCombination -> [ self actDueTo: #keyPressed ]).
	($p meta shift -> [ self exportAsPNGSilently ])"}
]

{ #category : #action }
GtSpotterElement >> diveInDueTo: anEventType [

	self spotterModelDo: [ :aSpotter |
		aSpotter hasSelected
			ifTrue: [ aSpotter currentStep diveInDueTo: anEventType ] ]
]

{ #category : #action }
GtSpotterElement >> diveOutDueTo: anEventType [

	self spotterModelDo: [ :aSpotter |
		aSpotter hasSelected
			ifTrue: [ aSpotter currentStep diveOutDueTo: anEventType ] ]
]

{ #category : #action }
GtSpotterElement >> exitDueTo: anEventType [
	self spotterModelDo: [ :aSpotter | aSpotter exitDueTo: anEventType ]
]

{ #category : #initialization }
GtSpotterElement >> initialize [
	| aTopBar |
	super initialize.

	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	breadcrumb := GtSpotterBreadcrumb new.

	searchField := GtSpotterSearchField new.
	searchField vFitContent; hMatchParent.
	
	aTopBar := BlElement new.
	aTopBar layout: BlLinearLayout horizontal.
	aTopBar constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	
	aTopBar addChildren: { searchField }.
	
	stepsPager := GtSpotterPager new.
	
	self addChildren: { breadcrumb . aTopBar . stepsPager }.
	
	self initializeListeners
]

{ #category : #initialization }
GtSpotterElement >> initializeListeners [
	self bindingDictionnary
		associationsDo: [ :anAssociation |
			self addShortcut: (BlShortcut new combination: anAssociation key; action: anAssociation value).
			searchField removeShortcutsWithCombination: anAssociation key ]
]

{ #category : #'event - handling' }
GtSpotterElement >> onCloseSpotter [
	"Check if I am opened in a separate window, then close that window otherwise just remove me from the space"
	(self isAttachedToSceneGraph
		and: [ self space root == self ])
			ifTrue: [ self space close ]
			ifFalse: [ self removeFromParent ]
]

{ #category : #'event - handling' }
GtSpotterElement >> onHidePreview [
]

{ #category : #'event - handling' }
GtSpotterElement >> onShowPreview [
	
]

{ #category : #accessing }
GtSpotterElement >> spotterModel: aSpotter [

	spotterModel := aSpotter.
	
	searchField spotterModel: aSpotter.
	stepsPager spotterModel: aSpotter.
	breadcrumb spotterModel: aSpotter.
	
	spotterModel announcer when: GtSpotterExitAnnouncement send: #onCloseSpotter to: self.
	spotterModel announcer when: GtSpotterShowPreview send: #onShowPreview to: self.
	spotterModel announcer when: GtSpotterHidePreview send: #onHidePreview to: self.
	
	spotterModel class isPreviewVisible
		ifTrue: [ spotterModel showPreview ]
]

{ #category : #accessing }
GtSpotterElement >> spotterModelDo: aBlock [
	spotterModel ifNotNil: aBlock
]
