Class {
	#name : #GtSpotterBreadcrumb,
	#superclass : #BrBreadcrumb,
	#instVars : [
		'spotterModel'
	],
	#category : #'GToolkit-Spotter-UI-Bloc'
}

{ #category : #'event handling' }
GtSpotterBreadcrumb >> addStep: aNewStep [
	| aText  |

	aText := self spotterModel steps size <= 1
		ifTrue: [ self spotterModel steps first origin gtDisplayText asRopedText ]
		ifFalse: [
			| aPreviousStep selectedItem origin |
			aPreviousStep := (aNewStep spotter steps at: aNewStep spotter steps size - 1).

			selectedItem := aPreviousStep selected item.
			origin := aNewStep origin.
			
			(selectedItem = origin)
				ifTrue: [ (aPreviousStep selected renderingProcessor render: selectedItem) labelBrick text ]
				ifFalse: [ (origin isKindOf: Collection)
					ifTrue: [ aNewStep processors first title ]
					ifFalse: [ origin gtDisplayString] ] ].

	self addItem: (BrLabel new
		look: (BrGlamorousLabelLook new foreground: Color white);
		alignCenter;
		background: (Color gray alpha: 0.4);
		text: aText).
]

{ #category : #initialization }
GtSpotterBreadcrumb >> initialize [
	super initialize.
	
	self look: (BrBreadcrumbScrollableLook new separator: [
		BrLabel new
			look: (BrGlamorousLabelLook new thin foreground: Color gray);
			text: '>';
			margin: (BlInsets left: 5 right: 5) ]).

	self
		hMatchParent;
		vExact: 28
]

{ #category : #'event handling' }
GtSpotterBreadcrumb >> onStepAdded: anAnnouncement [
	self addStep: anAnnouncement stepModel
]

{ #category : #'event handling' }
GtSpotterBreadcrumb >> onStepPopped: anAnnouncement [
]

{ #category : #accessing }
GtSpotterBreadcrumb >> spotterModel [
	^ spotterModel
]

{ #category : #accessing }
GtSpotterBreadcrumb >> spotterModel: aSpotterModel [

	spotterModel := aSpotterModel.

	spotterModel announcer when: GtSpotterStepAdded send: #onStepAdded: to: self.
	spotterModel announcer when: GtSpotterStepPopped send: #onStepPopped: to: self.

	aSpotterModel steps do: [ :eachStep | self addStep: eachStep ]
]
