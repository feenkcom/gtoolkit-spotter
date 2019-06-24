Class {
	#name : #GtSpotterContentsBrick,
	#superclass : #GLMBrick,
	#instVars : [
		'headerBrick',
		'dropDownBrick',
		'spotterModel'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #accessing }
GtSpotterContentsBrick >> dropDownBrick [
	^ dropDownBrick
]

{ #category : #accessing }
GtSpotterContentsBrick >> dropDownBrick: aBrick [
	dropDownBrick ifNotNil: [self removeBrick: dropDownBrick].
	dropDownBrick := aBrick asBrick.
	
	dropDownBrick morph pagerModel: self spotterModel pagerModel.
	self themer spotterThemer dropDownPaneStyleFor: dropDownBrick.
	
	self addBrickBack: dropDownBrick
	"aBrick openInWindow"
]

{ #category : #accessing }
GtSpotterContentsBrick >> headerBrick [
	^ headerBrick
]

{ #category : #accessing }
GtSpotterContentsBrick >> headerBrick: aBrick [
	
	headerBrick ifNotNil: [self removeBrick: headerBrick].
	headerBrick := aBrick.
	
	self themer spotterThemer headerStyleFor: headerBrick.
	
	self addBrickBack: headerBrick
]

{ #category : #initialization }
GtSpotterContentsBrick >> initialize [
	super initialize.
		
	self headerBrick: self newHeaderBrick.

]

{ #category : #testing }
GtSpotterContentsBrick >> isDropDownPaneVisible [

	^ self dropDownBrick isNotNil
]

{ #category : #'instance creation' }
GtSpotterContentsBrick >> newDropDownMorph [

	^ GtSpotterDropDownMorph new
]

{ #category : #'instance creation' }
GtSpotterContentsBrick >> newHeaderBrick [

	^ GtSpotterHeaderBrick new
]

{ #category : #'events-processing' }
GtSpotterContentsBrick >> onStepAdded [
	"as soon as step added I need to show drop down pane"
	self isDropDownPaneVisible ifTrue: [ ^ self ].
	
	self showDropDownPane
]

{ #category : #'brick-properties-events' }
GtSpotterContentsBrick >> onThemerChanged [
	super onThemerChanged.
	
	self themer spotterThemer spotterContentsWidgetStyleFor: self
]

{ #category : #actions }
GtSpotterContentsBrick >> showDropDownPane [

	self dropDownBrick: self newDropDownMorph.
	self dropDownBrick spotterModel: self spotterModel.
]

{ #category : #accessing }
GtSpotterContentsBrick >> spotterModel [

	^ spotterModel
]

{ #category : #accessing }
GtSpotterContentsBrick >> spotterModel: aModel [

	spotterModel := aModel.
	self headerBrick spotterModel: spotterModel.
	
	spotterModel steps isEmpty ifFalse: [ spotterModel currentStep hasCandidates ifTrue: [ self showDropDownPane ] ].

	spotterModel announcer when: GtSpotterStepAdded send: #onStepAdded to: self.
]
