Class {
	#name : #GtSpotterResultsBrick,
	#superclass : #GLMStackedScrollPaneBrick,
	#instVars : [
		'stepModel',
		'categories'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #adding }
GtSpotterResultsBrick >> addCategory: aCategoryBrick [
	"Add a category brick as one of my children including category title.
	New category is added on position defined by spotter order of its processor.
	If there are two categories with the same order they are arranged using FIFO order.
	aCategoryBrick must not be nil.
	aCategoryBrick must not be already added
	aCategoryBrick must have at least one child item"
	self assert: aCategoryBrick isNotNil.
	self assert: aCategoryBrick hasOwner not.
	self assert: aCategoryBrick hasSubbricks.
	
	self band hasSubbricks
		ifFalse: [ 
			self band addBrickBack: aCategoryBrick titleBrick.
			self band addBrickBack: aCategoryBrick	]
		ifTrue: [ 
			|index|
			"initialize index with 2 because every second child in the list
			is category itself and all others are category titles"
			index := 2.
			[ index <= self band subbricksCount and: [ 
				(self band subbricks at: index) order <= aCategoryBrick order ] ]
			whileTrue: [ index := index + 2 ].
			index > self band subbricksCount
				"If all existing categories has order less than new one we just add to back"
				ifTrue: [
					self band addBrickBack: aCategoryBrick titleBrick.
					self band addBrickBack: aCategoryBrick ]
				"otherwise add after the last category with the same or smaller order"
				ifFalse: [ 
					self band addBrick: aCategoryBrick titleBrick after: (self band subbricks at: index).
					self band addBrick: aCategoryBrick titleBrick after: aCategoryBrick titleBrick ] ]
	
]

{ #category : #adding }
GtSpotterResultsBrick >> addItem: anItemBrick to: aCategoryBrick [
	"Add new item brick to the specified category. If category brick has no items
	it will be added to spotter ui.
	anItemBrick must not be nil.
	aCategoryBrick must not be nil"
	|shouldAddCategory|
	self assert: anItemBrick isNotNil.
	self assert: aCategoryBrick isNotNil.
	
	"if category has no items we need to add it in the list"
	shouldAddCategory := aCategoryBrick hasSubbricks not.
	"add new item"
	aCategoryBrick addItem: anItemBrick.
	"add category to the list"
	shouldAddCategory ifTrue: [ self addCategory: aCategoryBrick ]
	
	
]

{ #category : #adding }
GtSpotterResultsBrick >> addItems: aCollectionOfItems to: aCategoryBrick [
	"Add new items from a collection to the specified category. If category brick has no items
	it will be added to spotter ui.
	aCollectionOfItems must not be nil.
	aCollectionOfItems must not be empty.
	aCategoryBrick must not be nil"
	|shouldAddCategory|
	self assert: aCollectionOfItems isNotNil.
	self assert: aCollectionOfItems isNotEmpty.
	self assert: aCategoryBrick isNotNil.
	
	"if category has no items we need to add it in the list"
	shouldAddCategory := aCategoryBrick hasSubbricks not.
	"add new item"
	aCategoryBrick addItems: aCollectionOfItems.
	"add category to the list"
	shouldAddCategory ifTrue: [ self addCategory: aCategoryBrick ]
	
	
]

{ #category : #adding }
GtSpotterResultsBrick >> buildCategoryBrick: aProcessor [
	"Create and initialize new container brick to contain candidates for aProcessor.
	Also creates a category title brick and assigns it to category brick to be
	added later to results brick as soon as there is more than one candidate"
	<return: #GtSpotterCategoryBrick>
	|titleBrick categoryBrick|
	
	"Initialize and style category title"
	titleBrick := self newTitleBrick on: self stepModel category: aProcessor.
	self themer spotterThemer categoryTitleStyleFor: titleBrick.
	
	"Initialize and style category container"
	categoryBrick := self newCategoryBrick on: self stepModel category: aProcessor.
	self themer spotterThemer categoryStyleFor: categoryBrick.
	
	"Assign title to category which will be added later to results brick"
	categoryBrick titleBrick: titleBrick.
	
	^ categoryBrick
]

{ #category : #adding }
GtSpotterResultsBrick >> buildItemFor: aCandidateLink in: aProcessor [
	|itemBrick|
	itemBrick := (aCandidateLink renderingProcessor render: aCandidateLink value)
			candidateLink: aCandidateLink;
			stepModel: self stepModel;
			yourself.
	^ itemBrick
	
]

{ #category : #accessing }
GtSpotterResultsBrick >> categories [
	<return: #Dictionary>
	^ categories
]

{ #category : #accessing }
GtSpotterResultsBrick >> categoryBrickFor: aProcessor [
	"Return a container brick that contains candidates for aProcessor.
	If category brick for aProcessor is requested for the first time
	it gets created without being added to spotter UI"
	<return: #GtSpotterCategoryBrick>
	
	^ self categories
		at: aProcessor
		ifAbsentPut: [ self buildCategoryBrick: aProcessor ]
]

{ #category : #accessing }
GtSpotterResultsBrick >> categoryBrickOf: aProcessor [
	"Return a container brick that contains candidates for aProcessor.
	If category brick for aProcessor does not exist throw an error"
	<return: #GtSpotterCategoryBrick>
	<throws: #Error when: 'Category for aProcessor does not exist'>
	
	^ self categories
		at: aProcessor
		ifAbsent: [ Error signal: 'Category for ', aProcessor asString, ' does not exist' ]
]

{ #category : #accessing }
GtSpotterResultsBrick >> categoryBrickOf: aProcessor ifAbsent: aBlock [
	"Return a container brick that contains candidates for aProcessor.
	If category brick for aProcessor does not exist evaluate aBlock"
	<return: #GtSpotterCategoryBrick>
	
	^ self categories
		at: aProcessor
		ifAbsent: aBlock
]

{ #category : #drawing }
GtSpotterResultsBrick >> clipSubmorphs [

	^ true
]

{ #category : #initialization }
GtSpotterResultsBrick >> initialize [
	super initialize.
	
	categories := Dictionary new.
	self band hSpaceFill.
	self announcer when: GLMBrickScrollPositionChanged send: #onScrolled to: self
]

{ #category : #'instance creation' }
GtSpotterResultsBrick >> newCategoryBrick [

	^ GtSpotterCategoryBrick new
]

{ #category : #'instance creation' }
GtSpotterResultsBrick >> newTitleBrick [

	^ GtSpotterCategoryTitleBrick new
]

{ #category : #'event handling' }
GtSpotterResultsBrick >> onAllCandidatesAdded: anAnnouncement [
	"first exit if collection is empty"
	anAnnouncement candidateLinks ifEmpty: [ ^ self ].
	self
		addItems: (anAnnouncement candidateLinks collect: [ :each | self buildItemFor: each in: anAnnouncement category ])
		to: (self categoryBrickFor: anAnnouncement category)
]

{ #category : #'event handling' }
GtSpotterResultsBrick >> onAllCandidatesRemoved [
	
	self removeAllBricks.
	categories := Dictionary new.
	self changed
	
]

{ #category : #'event handling' }
GtSpotterResultsBrick >> onCandidateAdded: anAnnouncement [
	self
		addItem: (self buildItemFor: anAnnouncement candidateLink in: anAnnouncement category)
		to: (self categoryBrickFor: anAnnouncement category)
]

{ #category : #'event handling' }
GtSpotterResultsBrick >> onCandidateSelected: ann [
	|processor categoryBrick itemBrick titleBrick scrollTo|

	processor := ann itemBrick processor.	
	categoryBrick := self categoryBrickOf: processor ifAbsent: [ ^ self ].
	itemBrick := ann itemBrick.
	titleBrick := categoryBrick titleBrick.
	scrollTo := (itemBrick candidateLink isFirst and: [ titleBrick isFirstInOwner ])
		ifTrue: [ titleBrick ]
		ifFalse: [ itemBrick ].
	self scrollTo: scrollTo
]

{ #category : #'event handling' }
GtSpotterResultsBrick >> onCandidatesAmountChanged: ann [
	|categoryMorph|
	
	categoryMorph := self categoryBrickOf: ann category.
	categoryMorph setAmountVisible: (categoryMorph submorphs size) all: ann amount.
	
]

{ #category : #'event handling' }
GtSpotterResultsBrick >> onRemovedFrom: aBrick [
	super onRemovedFrom: aBrick.
	
	self stepModel spotter announcer unsubscribe: self.
	self stepModel announcer unsubscribe: self.
	self stepModel candidates announcer unsubscribe: self
]

{ #category : #'event handling' }
GtSpotterResultsBrick >> onScrolled [

	self stepModel spotter announce: GtSpotterCandidateSelectedMoved new
]

{ #category : #accessing }
GtSpotterResultsBrick >> stepModel [
	^ stepModel
]

{ #category : #accessing }
GtSpotterResultsBrick >> stepModel: aModel [
	stepModel := aModel.
	
	stepModel candidates announcer when: GtSpotterCandidateAdded send: #onCandidateAdded: to: self.
	stepModel candidates announcer when: GtSpotterAllCandidatesRemoved send: #onAllCandidatesRemoved to: self.
	stepModel candidates announcer when: GtSpotterAllCandidatesAdded send: #onAllCandidatesAdded: to: self.
	stepModel candidates announcer when: GtSpotterCandidatesAmountChanged send: #onCandidatesAmountChanged: to: self.
	stepModel announcer when: GtSpotterScrollPageDown send: #scrollPageDown to: self.
	stepModel announcer when: GtSpotterScrollPageUp send: #scrollPageUp to: self.
	stepModel announcer when: GtSpotterCandidateSelected send: #onCandidateSelected: to: self
]

{ #category : #accessing }
GtSpotterResultsBrick >> waitingText [

	^ '...'
]
