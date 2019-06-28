Class {
	#name : #GtSpotterPager,
	#superclass : #BrPager,
	#instVars : [
		'spotterModel'
	],
	#category : #'GToolkit-Spotter-UI-Bloc'
}

{ #category : #initialization }
GtSpotterPager >> initialize [
	super initialize.
	
	self constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ]
]

{ #category : #accessing }
GtSpotterPager >> onStepAdded: anAnnouncement [
	"as soon as step added we need to push it"
	
	self pushStep: anAnnouncement stepModel
]

{ #category : #'actions api' }
GtSpotterPager >> pushStep: aSpotterStep [
	| aStepElement aPageModel aPageContainer |
	
	aStepElement := aSpotterStep asElement.
	
	aPageModel := BrPagerPageModel new.
	aPageModel model: aSpotterStep.
	
	aPageContainer := BlElement new.
	aPageContainer constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	
	aPageContainer addChild: aStepElement.
	aPageContainer viewModel: aPageModel.
	
	self addPage: aPageContainer
]

{ #category : #accessing }
GtSpotterPager >> spotterModel [
	^ spotterModel
]

{ #category : #accessing }
GtSpotterPager >> spotterModel: aModel [ 
	spotterModel := aModel.
	
	spotterModel steps do: [ :eachStep | self pushStep: eachStep ].
	
	spotterModel announcer when: GtSpotterStepAdded send: #onStepAdded: to: self.
]
