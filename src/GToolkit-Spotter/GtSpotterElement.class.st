Class {
	#name : #GtSpotterElement,
	#superclass : #BlElement,
	#instVars : [
		'spotterModel',
		'searchField',
		'stepsPager',
		'closeButton'
	],
	#category : #'GToolkit-Spotter-UI-Bloc'
}

{ #category : #initialization }
GtSpotterElement >> initialize [
	| aTopBar |
	super initialize.

	self layout: BlLinearLayout vertical.
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].

	searchField := GtSpotterSearchField new.
	searchField vFitContent; hMatchParent.
	
	closeButton := BrButton new
			look: BrGlamorousButtonWithIconLook;
			icon: BrGlamorousIcons close asElement;
			action: [ self spotterModelDo: [ :aSpotter | aSpotter exitDueTo: #actionButton ] ].
	
	aTopBar := BlElement new.
	aTopBar layout: BlLinearLayout horizontal.
	aTopBar constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical fitContent ].
	
	aTopBar addChildren: { searchField . closeButton }.
	
	stepsPager := GtSpotterPager new.
	
	self addChildren: { aTopBar . stepsPager }
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
