Class {
	#name : #GtSpotterMorph,
	#superclass : #BlElement,
	#instVars : [
		'focusedMorph',
		'breadcrumbBrick',
		'paneBrick',
		'spotterModel',
		'autoHide',
		'processorKeyBindings'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #actions }
GtSpotterMorph >> actDueTo: anEventType [
	self spotterModelDo: [
		self spotterModel hasSteps ifFalse: [ ^self ].
		self spotterModel currentStep hasCandidates ifFalse: [ ^ self ].
		self spotterModel currentStep actDueTo: anEventType ]
]

{ #category : #accessing }
GtSpotterMorph >> autoHide [

	^ autoHide ifNil: [ autoHide := true ]
]

{ #category : #accessing }
GtSpotterMorph >> autoHide: aBoolean [

	autoHide := aBoolean
]

{ #category : #initialization }
GtSpotterMorph >> bindingDictionnary [
	^ {(Character escape -> [ self spotterModel exitDueTo: #keyPressedEscape ]).
	($w meta -> [ self spotterModel exitDueTo: #keyPressedW ]).
	($p meta -> [ self togglePreview ]).
	($i meta -> [ self spotterModel inspectIt ]).
	($d meta -> [ self spotterModel doIt ]). 
	(Character arrowUp -> [ self selectPreviousCandidateDueTo: #keyPressedArrowUp ]).
	(Character arrowDown -> [ self selectNextCandidateDueTo: #keyPressedArrowDown ]).
	(Character arrowUp meta -> [ self selectPreviousCandidateDueTo: #keyPressedArrowUp ]).
	(Character arrowDown meta -> [ self selectNextCandidateDueTo: #keyPressedArrowDown ]).
	(Character arrowUp shift -> [ self selectPreviousCandidateDueTo: #keyPressedArrowUp ]).
	(Character arrowDown shift -> [ self selectNextCandidateDueTo: #keyPressedArrowDown ]).
	(Character arrowUp meta shift -> [ self selectPreviousCategory ]).
	(Character arrowDown meta shift -> [ self selectNextCategory ]).
	(Character arrowRight meta -> [ self diveInDueTo: #keyPressed ]).
	(Character arrowLeft meta -> [ self diveOut ]).
	(Character arrowRight meta shift -> [ self diveInCategoryDueTo: #keyPressed ]).
	(Character arrowLeft meta shift -> [ self diveOut ]).
	(Character arrowUp alt -> [ self stepScrollPageUp ]).
	(Character arrowDown alt -> [ self stepScrollPageDown ]).
	(Character pageUp -> [ self stepScrollPageUp ]).
	(Character pageDown -> [ self stepScrollPageDown ]).
	(Character cr asKeyCombination -> [ self actDueTo: #keyPressed ]).
	($p meta shift -> [ self exportAsPNGSilently ])}
]

{ #category : #accessing }
GtSpotterMorph >> breadcrumbBrick [
	
	^ breadcrumbBrick
]

{ #category : #accessing }
GtSpotterMorph >> breadcrumbBrick: aBrick [

	breadcrumbBrick ifNotNil: [self removeBrick: breadcrumbBrick].
	breadcrumbBrick := aBrick.
	
	breadcrumbBrick announcer when: GtSpotterBreadcrumbVisibilityChanged send: #onBreadcrumbVisibilityChanged to: self.
	self themer spotterThemer breadcrumbStyleFor: breadcrumbBrick.
	breadcrumbBrick width: [ self paneBrick contentsBrick width ].
	breadcrumbBrick layout widthDependency: [ self paneBrick contentsBrick ].
	self addBrickBack: breadcrumbBrick
]

{ #category : #actions }
GtSpotterMorph >> closeSpotter [

	self autoHide ifTrue: [ self delete ]
]

{ #category : #'accessing-defaults' }
GtSpotterMorph >> defaultLabel [
	^ 'Spotter'
]

{ #category : #actions }
GtSpotterMorph >> diveInCategoryDueTo: anEventType [

	self spotterModelDo: [ :aSpotter |
		aSpotter hasSelected
			ifTrue: [ aSpotter currentStep diveInCategoryDueTo: anEventType ] ]
]

{ #category : #actions }
GtSpotterMorph >> diveInDueTo: anEventType [

	self spotterModelDo: [ :aSpotter |
		aSpotter hasSelected
			ifTrue: [ aSpotter currentStep diveInDueTo: anEventType ] ]
]

{ #category : #actions }
GtSpotterMorph >> diveOut [
	self spotterModelDo: [ 
		self spotterModel popStep ]
]

{ #category : #'events-processing' }
GtSpotterMorph >> handleListenEvent: anEvent [
		
	anEvent type = #mouseDown ifTrue: [ 
		((self fullBoundsInWorld containsPoint: anEvent position) not and: [ self autoHide ])
			ifTrue: [ self spotterModel ifNotNil: [ :aModel | aModel exitDueTo: #mouseDown ] ] ].
		
	anEvent type = #keyDown ifTrue: [ 
		self spotterModel
			ifNotNil: [ :s | s shiftPressed: (InputEventSensor default anyModifierKeyPressed not & InputEventSensor default shiftPressed) ] ].
]

{ #category : #private }
GtSpotterMorph >> handleProcessorKeyBindings [
	self processorKeyBindingsDo: [
		self spotterModel currentStep ifNotNil: [ 
			self spotterModel currentStep processors do: [ :processor | 
				processor keyBinding ifNotNil: [ 
					| keyCombination |
					keyCombination := processor keyBinding asKeyCombination.
					processorKeyBindings at: keyCombination put: processor.
					self kmDispatcher bindKeyCombination: keyCombination toAction: [ self onKeyProcessor: processor ] ] ] ] ]
]

{ #category : #'event handling' }
GtSpotterMorph >> handlesMouseDown: evt [
	^ true
]

{ #category : #actions }
GtSpotterMorph >> hidePreview [
	
	self spotterModel hidePreview
]

{ #category : #initialization }
GtSpotterMorph >> initialize [
	super initialize.
	"setting custom brick themer for the whole spotter"
	self themer: self themer spotterThemer themer.
	
	self initializeListeners.
	self themer spotterThemer spotterStyleFor: self.
	
	self breadcrumbBrick: self newBreadcrumbBrick.
	self paneBrick: self newPaneBrick.

	
	
	
]

{ #category : #initialization }
GtSpotterMorph >> initializeListeners [
	self activeHand addEventListener: self.
	Morph announcer weak when: MorphLostFocus send: #onLostFocus: to: self.
	self bindingDictionnary
		associationsDo: [ :anAssociation | self bindKeyCombination: anAssociation key toAction: anAssociation value ].
	processorKeyBindings := Dictionary new.
]

{ #category : #'instance creation' }
GtSpotterMorph >> newBreadcrumbBrick [

	^ GtSpotterStepsBreadcrumb new
]

{ #category : #'instance creation' }
GtSpotterMorph >> newPaneBrick [

	^ GtSpotterPaneBrick new
]

{ #category : #'events-processing' }
GtSpotterMorph >> onBreadcrumbVisibilityChanged [

	self changed.
]

{ #category : #'events-processing' }
GtSpotterMorph >> onHidePreview [
	|delta|
	self paneBrick isPreviewShown ifFalse: [ ^ self ].
	delta := ((self width - ((self width / 100) * (100 - self themer spotterThemer previewWidthPercent)))@0) negated / 2.
	self bounds: (self bounds expandBy: delta rounded).
	self paneBrick hidePreview.
	self doLayout
]

{ #category : #private }
GtSpotterMorph >> onKeyProcessor: aProcessor [
	" this is really ugly, we should make an abstraction of the query/input and the key-identifier of a processor ...... "
	| searchField newText newTextFragment newSelection oldText oldSelection oldSelectionOffset newSeparator newSeparatorOffset |
	aProcessor title isEmptyOrNil ifTrue: [ ^ self ].
	searchField := [ paneBrick contentsBrick headerBrick searchField ] on: Error do: [ ^ self ]. " ups "
	" backup old text and selection "
	oldText := searchField text asString.
	oldSelection := searchField rubric selectionInterval.
	oldSelectionOffset := 0.
	" create the new text (first fragment only) "
	newTextFragment := '#' , (aProcessor title copyUpTo: Character space).
	newSeparatorOffset := 0. " togle between categories -> add 0 extra space/offset "
	(oldText includesSubstring: newTextFragment caseSensitive: false) ifTrue: [ 
		newSeparatorOffset := -1. 
		newTextFragment := '' ].  " already present -> toggle -> remove 1 extra space/offset "
	" try replacing the old category by the new one - preserving the relative cursor position "
	(oldText includesSubstring: '#' caseSensitive: false) 
		ifTrue: [ 
			| oldTextFragmentStart oldTextFragmentStop oldTextFragment |
			oldTextFragmentStart := oldText indexOf: $#.
			oldTextFragmentStop := oldText indexOf: Character space startingAt: oldTextFragmentStart + 1 ifAbsent: [ oldText size ].
			oldTextFragment := (oldText copyFrom: 1 to: oldTextFragmentStart - 1) , (oldText copyFrom: oldTextFragmentStop + 1 to: oldText size).
			oldSelectionOffset := 0 - (oldTextFragmentStop - oldTextFragmentStart).
			oldText := oldTextFragment ]
		ifFalse: [ 
			newSeparatorOffset := 1. " add new -> add 1 extra space/offset " ].
	" try avoiding adding unneccessary spaces "
	newSeparator := (newTextFragment isEmpty or: [ (oldText at: 1 ifAbsent: [ nil ]) = Character space ])
		ifTrue: [ '' ] 
		ifFalse: [ ' ' ].
	" create and set the new text "
	newText := newTextFragment , newSeparator , oldText.
	" set the new cursor position "
	newSelection := (oldSelectionOffset + newTextFragment size + oldSelection first + newSeparatorOffset) to: (oldSelectionOffset + newTextFragment size + oldSelection last + newSeparatorOffset).
	searchField
		text: newText;
		selectFrom: newSelection first to: newSelection last
]

{ #category : #'events-processing' }
GtSpotterMorph >> onLostFocus: event [

	focusedMorph ifNil: [ focusedMorph := event morph ]
]

{ #category : #'events-processing' }
GtSpotterMorph >> onShowPreview [

	|delta|
	self paneBrick isPreviewShown ifTrue: [ ^ self ].
	delta := (((self width * 100) / (100 - self themer spotterThemer previewWidthPercent) - self width)@0) / 2.
	self bounds: (self bounds expandBy: delta rounded).
	self paneBrick showPreview.
	self doLayout
]

{ #category : #opening }
GtSpotterMorph >> openInWindowLabeled: aString inWorld: aWorld [
	self autoHide: false.
	^ super openInWindowLabeled: aString inWorld: aWorld
]

{ #category : #initialization }
GtSpotterMorph >> outOfWorld: aWorld [
	super outOfWorld: aWorld.
	self unsubscribeListeners.
	
	self spotterModel ifNotNil: [:m | m terminateProcessors].
	
	"restoring previous focus"
	focusedMorph ifNotNil: [ focusedMorph takeKeyboardFocus ]
]

{ #category : #accessing }
GtSpotterMorph >> paneBrick [

	^ paneBrick
]

{ #category : #accessing }
GtSpotterMorph >> paneBrick: aBrick [
	
	paneBrick ifNotNil: [self removeBrick: paneBrick].
	paneBrick := aBrick.
		
	self themer spotterThemer spotterPaneStyleFor: paneBrick.

	self addBrickBack: paneBrick
]

{ #category : #private }
GtSpotterMorph >> processorKeyBindingsDo: aBlock [
	processorKeyBindings ifNotNil: [ 
		processorKeyBindings keys do: [ :each | 
			self kmDispatcher removeKeyCombination: each ] ].
	processorKeyBindings := Dictionary new.
	aBlock value
]

{ #category : #actions }
GtSpotterMorph >> selectNextCandidateDueTo: anEventType [

	self spotterModel hasSelected
		ifTrue: [ self spotterModel currentStep selectNextDueTo: anEventType ]
]

{ #category : #actions }
GtSpotterMorph >> selectNextCategory [

	self spotterModel hasSelected
		ifTrue: [ self spotterModel currentStep selectNextCategory ]
	
]

{ #category : #actions }
GtSpotterMorph >> selectPreviousCandidateDueTo: anEventType [

	self spotterModel hasSelected
		ifTrue: [ self spotterModel currentStep selectPreviousDueTo: anEventType ]
	
]

{ #category : #actions }
GtSpotterMorph >> selectPreviousCategory [

	self spotterModel hasSelected
		ifTrue: [ self spotterModel currentStep selectPreviousCategory ]
	
]

{ #category : #actions }
GtSpotterMorph >> showPreview [
	
	self spotterModel showPreview
]

{ #category : #accessing }
GtSpotterMorph >> spotterModel [

	^ spotterModel
]

{ #category : #accessing }
GtSpotterMorph >> spotterModel: aSpotter [

	spotterModel := aSpotter.
	
	spotterModel announcer when: GtSpotterExitAnnouncement send: #closeSpotter to: self.
	spotterModel announcer when: GtSpotterShowPreview send: #onShowPreview to: self.
	spotterModel announcer when: GtSpotterHidePreview send: #onHidePreview to: self.
	
	self breadcrumbBrick spotterModel: spotterModel.
	self paneBrick spotterModel: spotterModel.
	
	spotterModel class isPreviewVisible ifTrue: [ spotterModel showPreview ].
	
	"expanding drop down pane"
	self spotterModelDo: [ 
		self spotterModel setText: '' from: nil.
		self spotterModel currentStep process: nil ]
	
	
	
]

{ #category : #private }
GtSpotterMorph >> spotterModelDo: aBlock [
	self spotterModel handleExceptionsDuring: [ 
		aBlock cull: self spotterModel.
		self handleProcessorKeyBindings ]
]

{ #category : #actions }
GtSpotterMorph >> stepScrollPageDown [

	self spotterModel currentStep announcer announce: (GtSpotterScrollPageDown new)
]

{ #category : #actions }
GtSpotterMorph >> stepScrollPageUp [

	self spotterModel currentStep announcer announce: (GtSpotterScrollPageUp new)
]

{ #category : #actions }
GtSpotterMorph >> togglePreview [

	self spotterModel togglePreview
]

{ #category : #initialization }
GtSpotterMorph >> unsubscribeListeners [

	self activeHand removeEventListener: self.
	Morph announcer unsubscribe: self.
]
