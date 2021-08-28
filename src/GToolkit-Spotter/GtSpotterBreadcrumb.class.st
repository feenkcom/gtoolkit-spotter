Class {
	#name : 'GtSpotterBreadcrumb',
	#superclass : 'BrBreadcrumb',
	#traits : 'TBrSelectable',
	#classTraits : 'TBrSelectable classTrait',
	#instVars : [
		'spotterModel'
	],
	#category : 'GToolkit-Spotter-UI'
}

{ #category : 'private' }
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
				ifTrue: [ aPreviousStep selected renderingProcessor itemNameFor: selectedItem ]
				ifFalse: [ (origin isKindOf: Collection)
					ifTrue: [ aNewStep processors first title ]
					ifFalse: [ origin gtDisplayText ] ] ].

	self addItem: (BrButton new
		aptitude: (BrGlamorousButtonRectangularAptitude + (BrGlamorousButtonLabelAptitude new selectedColor: Color black));
		action: [ self spotterModel currentStep: aNewStep ];
		alignCenterLeft;
		label: aText).
]

{ #category : 'initialization' }
GtSpotterBreadcrumb >> initialize [
	super initialize.
	
	self viewModel add: (selectionModel := BrSelectionModel new).

	self aptitude: (BrBreadcrumbLinearAptitude new separator: [
		BrLabel new
			aptitude: (BrGlamorousLabelAptitude new thin foreground: Color gray);
			text: '>';
			margin: (BlInsets left: 5 right: 5) ]).

	self
		hMatchParent;
		vExact: 40;
		alignCenterLeft.

	self when: BrSelectionChanged do: [ :anEvent |
		anEvent withIndexDo: [ :anIndex :isSelected |
			 (self itemAt: anIndex) dispatchEvent: (BlElementSelectedStateWish selected: isSelected) ] ]
]

{ #category : 'event handling' }
GtSpotterBreadcrumb >> onCurrentStepChanged: anAnnouncement [
	self selectOne: anAnnouncement index
]

{ #category : 'event handling' }
GtSpotterBreadcrumb >> onStepAdded: anAnnouncement [
	self addStep: anAnnouncement stepModel
]

{ #category : 'event handling' }
GtSpotterBreadcrumb >> onStepRemoved: anAnnouncement [
	self removeItemAt: anAnnouncement index
]

{ #category : 'accessing' }
GtSpotterBreadcrumb >> spotterModel [
	^ spotterModel
]

{ #category : 'accessing' }
GtSpotterBreadcrumb >> spotterModel: aSpotterModel [

	spotterModel := aSpotterModel.

	spotterModel announcer when: GtSpotterStepAdded send: #onStepAdded: to: self.
	spotterModel announcer when: GtSpotterStepRemoved send: #onStepRemoved: to: self.
	spotterModel announcer when: GtSpotterCurrentStepChanged send: #onCurrentStepChanged: to: self.
	
	aSpotterModel steps do: [ :eachStep | self addStep: eachStep ].
	
	self selectOne: aSpotterModel currentStepIndex
]
