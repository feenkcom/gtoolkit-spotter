Class {
	#name : #GtSpotterCategoryBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'listBrick',
		'titleBrick',
		'stepModel',
		'category'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #adding }
GtSpotterCategoryBrick >> addItem: anItem [
	self addBrickBack: anItem
]

{ #category : #adding }
GtSpotterCategoryBrick >> addItems: aCollectionOfItems [
	self addAllBricks: aCollectionOfItems
]

{ #category : #accessing }
GtSpotterCategoryBrick >> category [

	^ category
]

{ #category : #accessing }
GtSpotterCategoryBrick >> category: aProcessorClass [

	category := aProcessorClass
]

{ #category : #initialization }
GtSpotterCategoryBrick >> initialize [
	super initialize.
	self
		useVerticalLinearLayout;
		vShrinkWrap;
		initializeListeners;
		enable
]

{ #category : #initialization }
GtSpotterCategoryBrick >> initializeListeners [
	self announcer when: #onMouseHover send: #onHovered to: self. 
	self announcer when: #onMouseUnhover send: #onUnhovered to: self
]

{ #category : #'instance creation' }
GtSpotterCategoryBrick >> on: aStepModel category: aProcessor [

	self stepModel: aStepModel.
	self category: aProcessor.
]

{ #category : #'event handling' }
GtSpotterCategoryBrick >> onHovered [
	self titleBrick showActionbar
]

{ #category : #'event handling' }
GtSpotterCategoryBrick >> onUnhovered [
	(self stepModel isCategorySelected: self category)
		ifFalse: [ self titleBrick hideActionbar ]
]

{ #category : #accessing }
GtSpotterCategoryBrick >> order [
	^ self category order
]

{ #category : #'event handling' }
GtSpotterCategoryBrick >> privateAddIntoWorld: aBrick [
	super privateAddIntoWorld: aBrick.
	self setAmountVisible: self subbricksCount all: '...'
]

{ #category : #accessing }
GtSpotterCategoryBrick >> setAmountVisible: visible all: all [

	self titleBrick setAmountVisible: visible all: all
]

{ #category : #accessing }
GtSpotterCategoryBrick >> stepModel [
	^ stepModel
]

{ #category : #accessing }
GtSpotterCategoryBrick >> stepModel: anObject [
	stepModel := anObject.
]

{ #category : #accessing }
GtSpotterCategoryBrick >> titleBrick [
	^ titleBrick
]

{ #category : #accessing }
GtSpotterCategoryBrick >> titleBrick: aBrick [

	titleBrick := aBrick
]
