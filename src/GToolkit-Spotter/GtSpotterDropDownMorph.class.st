Class {
	#name : #GtSpotterDropDownMorph,
	#superclass : #GLMPagerBrick,
	#instVars : [
		'spotterModel'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #building }
GtSpotterDropDownMorph >> buildPane: aStepModel [
	|pane|
	
	pane := GTSpotterResultsBrick new stepModel: aStepModel.
	self brickThemer spotterThemer resultsPaneStyleFor: pane.
	^ pane
]

{ #category : #initialization }
GtSpotterDropDownMorph >> initialize [
	super initialize.
	
	self showScrollBarWhenNeeded: false
]

{ #category : #'event handling' }
GtSpotterDropDownMorph >> onStepAdded: ann [
	"as soon as step added we need to push it"

	self pushPane: (self buildPane: ann stepModel)
]

{ #category : #accessing }
GtSpotterDropDownMorph >> spotterModel [
	^ spotterModel
]

{ #category : #accessing }
GtSpotterDropDownMorph >> spotterModel: aModel [ 
	spotterModel := aModel.
	
	spotterModel steps do: [ :each | self pushPane: (self buildPane: each) ].
	
	spotterModel announcer when: GTSpotterStepAdded send: #onStepAdded: to: self.
]
