Class {
	#name : #GtSpotterHeaderBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'stepsBrick',
		'searchField',
		'closeButton',
		'spotterModel',
		'settingsButton',
		'helpButton'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #accessing }
GtSpotterHeaderBrick >> closeButton [

	^ closeButton
]

{ #category : #accessing }
GtSpotterHeaderBrick >> closeButton: aBrick [

	closeButton ifNotNil: [self removeBrick: closeButton].
	closeButton := aBrick.
	
	self themer spotterThemer closeButtonWidgetStyleFor: closeButton.
	self themer spotterThemer closeButtonStyleFor: closeButton.
	
	closeButton
		hintTitle: 'Close Spotter';
		hintText: '<escape>';
		action: [ self spotterModel exitDueTo: #actionButton ].
	
	self addBrickBack: closeButton
]

{ #category : #accessing }
GtSpotterHeaderBrick >> helpButton [

	^ helpButton
]

{ #category : #accessing }
GtSpotterHeaderBrick >> helpButton: aBrick [

	| tree item |
	helpButton ifNotNil: [self removeBrick: helpButton].
	helpButton := aBrick.
	
	self themer spotterThemer helpButtonWidgetStyleFor: helpButton.
	self themer spotterThemer helpButtonStyleFor: helpButton.
	
	helpButton
		hintTitle: 'Spotter help';
		action: [ 
			self spotterModel exitDueTo: #actionButton.
			tree := HelpBrowser open instVarNamed: #treeMorph.
			item := tree allItems detect: [:each | 
				each complexContents item key = GTSpotterHelp key].
			tree selection: item ].
	
	self addBrickBack: helpButton
]

{ #category : #initialization }
GtSpotterHeaderBrick >> initialize [
	super initialize.
	
	self searchField: self newSearchField.
	self class environment at: #GTEventRecorderSettings ifPresent: [
		self settingsButton: self newSettingsButton ].
	self helpButton: self newHelpButton.
	self closeButton: self newCloseButton.
	
]

{ #category : #'instance creation' }
GtSpotterHeaderBrick >> newCloseButton [

	^ GLMHintableActionButtonBrick new
]

{ #category : #'instance creation' }
GtSpotterHeaderBrick >> newHelpButton [

	^ GLMHintableActionButtonBrick new
]

{ #category : #'instance creation' }
GtSpotterHeaderBrick >> newSearchField [

	^ GLMRubTextFieldBrick new
]

{ #category : #'instance creation' }
GtSpotterHeaderBrick >> newSettingsButton [

	^ GLMHintableActionButtonBrick new
]

{ #category : #'instance creation' }
GtSpotterHeaderBrick >> newStepsBand [

	^ GLMBrick new
]

{ #category : #'event handling' }
GtSpotterHeaderBrick >> onCurrentStepChanged [

	self searchField rubric updateTextWith: self spotterModel currentStep context text.
	self searchField rubric selectFrom: self searchField rubric text size + 1 to: self searchField rubric text size
]

{ #category : #'event handling' }
GtSpotterHeaderBrick >> onHideHints [

	self themer spotterThemer hintHideStyleFor: self settingsButton.
	self themer spotterThemer hintHideStyleFor: self closeButton.
	self themer spotterThemer hintHideStyleFor: self helpButton.
]

{ #category : #'event handling' }
GtSpotterHeaderBrick >> onRevealHints [

	self themer spotterThemer hintRevealStyleFor: self settingsButton.
	self themer spotterThemer hintRevealStyleFor: self closeButton.
	self themer spotterThemer hintRevealStyleFor: self helpButton
]

{ #category : #'brick-properties-events' }
GtSpotterHeaderBrick >> onThemerChanged [
	super onThemerChanged.
	
	self themer spotterThemer headerWidgetStyleFor: self.
	self themer spotterThemer closeButtonWidgetStyleFor: self closeButton.
	self themer spotterThemer searchFieldWidgetStyleFor: self searchField.
	self themer spotterThemer settingsButtonWidgetStyleFor: self settingsButton
]

{ #category : #accessing }
GtSpotterHeaderBrick >> openSettingsBrowser [
	GLMPrivacyAgreementBrick openSettingsBrowser.
	self spotterModel exitDueTo: #openSettingsBrowser.
]

{ #category : #accessing }
GtSpotterHeaderBrick >> searchField [

	^ searchField
]

{ #category : #accessing }
GtSpotterHeaderBrick >> searchField: aBrick [

	searchField := aBrick.
	
	self themer spotterThemer searchFieldStyleFor: searchField.
	
	searchField morph takeKeyboardFocus.
	
	self addBrickBack: searchField
]

{ #category : #accessing }
GtSpotterHeaderBrick >> settingsButton [

	^ settingsButton
]

{ #category : #accessing }
GtSpotterHeaderBrick >> settingsButton: aBrick [

	settingsButton ifNotNil: [self removeBrick: settingsButton].
	settingsButton := aBrick.
	
	self themer spotterThemer settingsButtonWidgetStyleFor: settingsButton.
	self themer spotterThemer settingsButtonStyleFor: settingsButton.
	
	settingsButton
		hintTitle: 'Settings';
		hintText: 'Shows the settings UI';
		action: [ self openSettingsBrowser ].
	
	self addBrickBack: settingsButton
]

{ #category : #accessing }
GtSpotterHeaderBrick >> spotterModel [

	^ spotterModel
]

{ #category : #accessing }
GtSpotterHeaderBrick >> spotterModel: aModel [ 

	spotterModel := aModel.
	self searchField morph on: spotterModel.

	spotterModel announcer when: GTSpotterCurrentStepChanged send: #onCurrentStepChanged to: self.
	
	self spotterModel announcer when: GTSpotterRevealHints send: #onRevealHints to: self.
	self spotterModel announcer when: GTSpotterHideHints send: #onHideHints to: self.
]
