Class {
	#name : #GtSpotterItemBrick,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'iconBrick',
		'labelBrick',
		'actionbarBrick',
		'stepModel',
		'candidateLink'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #accessing }
GtSpotterItemBrick >> actionbarBrick [
	"Return action bar brick"

	^ actionbarBrick
]

{ #category : #accessing }
GtSpotterItemBrick >> actionbarBrick: aBrick [

	actionbarBrick ifNotNil: [ self removeBrick: actionbarBrick ].
	actionbarBrick := aBrick.

	
	self addBrickBack: actionbarBrick
]

{ #category : #actions }
GtSpotterItemBrick >> beSelected [
	self stepModel select: self candidateLink
]

{ #category : #accessing }
GtSpotterItemBrick >> candidateLink [

	^ candidateLink
]

{ #category : #accessing }
GtSpotterItemBrick >> candidateLink: aDoubleLink [ 

	candidateLink := aDoubleLink.
	
	self actionbarBrick candidateLink: self candidateLink
]

{ #category : #'event handling' }
GtSpotterItemBrick >> check [
	"#check on UI side means that item is selected in Spotter model"
	super check.

	self showActionbar.
	self notifySelected
]

{ #category : #'event handling' }
GtSpotterItemBrick >> checkOrUncheck [

	(self stepModel isSelected: self candidateLink)
		ifTrue: [ self isChecked ifFalse: [ self check ] ]
		ifFalse: [ self isChecked ifTrue: [ self uncheck ] ]
]

{ #category : #'event handling' }
GtSpotterItemBrick >> deselect [
	super deselect.
	self hideActionbar
]

{ #category : #'morphic - events' }
GtSpotterItemBrick >> doubleClick: anEvent [

	self stepModel actDueTo: #doubleClick
]

{ #category : #'morphic - events' }
GtSpotterItemBrick >> handlesMouseDown: evt [
	^ true
]

{ #category : #actions }
GtSpotterItemBrick >> hideActionbar [

	self shouldShowActionbar
		ifTrue: [ ^ self ].

	self actionbarBrick visible: false
]

{ #category : #actions }
GtSpotterItemBrick >> highlightQuery [
	self labelBrick label highlight: self stepModel context text
]

{ #category : #accessing }
GtSpotterItemBrick >> icon: aForm [

	self iconBrick normalImage: aForm.
]

{ #category : #accessing }
GtSpotterItemBrick >> iconBrick [
	^ iconBrick
]

{ #category : #accessing }
GtSpotterItemBrick >> iconBrick: aBrick [

	iconBrick ifNotNil: [ self removeBrick: iconBrick ].
	iconBrick := aBrick.

	self themer spotterThemer itemIconStyleFor: iconBrick.

	self addBrickBack: iconBrick
]

{ #category : #initialization }
GtSpotterItemBrick >> initialize [
	super initialize.
	self enable.

	self themer spotterThemer itemNormalStyleFor: self.

	self iconBrick: self newIconBrick.
	self labelBrick: self newLabelBrick.
	self actionbarBrick: self newActionbarBrick
]

{ #category : #accessing }
GtSpotterItemBrick >> labelBrick [
	^ labelBrick
]

{ #category : #accessing }
GtSpotterItemBrick >> labelBrick: aBrick [

	labelBrick ifNotNil: [self removeBrick: labelBrick].
	labelBrick := aBrick.
	
	self themer spotterThemer itemLabelStyleFor: labelBrick.
	
	self addBrickBack: labelBrick
]

{ #category : #'morphic - events' }
GtSpotterItemBrick >> mouseDown: evt [
	|selectors|
	
	self isEnabled ifFalse: [ ^ self ].
	
	selectors := Array
				with: #singleClick:
				with: #doubleClick:
				with: nil
				with: nil.
				
	evt hand
		waitForClicksOrDrag: self
		event: evt
		selectors: selectors
		threshold: 10
	
]

{ #category : #'instance creation' }
GtSpotterItemBrick >> newActionbarBrick [

	^ GtSpotterItemActionbarBrick new
]

{ #category : #'instance creation' }
GtSpotterItemBrick >> newIconBrick [

	^ GLMInteractableBrick new normalImage: ((Form extent: 16@16 depth: 32) fillAlpha: 0)
]

{ #category : #'instance creation' }
GtSpotterItemBrick >> newLabelBrick [
	self flag: 'find a better number, or at least a better place for the number :)'.

	^ GLMLabelBrick new 
		text: 'Search result with very very long name';
		paddingRight: 16
]

{ #category : #notifying }
GtSpotterItemBrick >> notifySelected [

	self stepModel spotter announce: (GtSpotterCandidateSelected new itemBrick: self).
	self stepModel announcer announce: (GtSpotterCandidateSelected new itemBrick: self)
]

{ #category : #'brick-layout-events' }
GtSpotterItemBrick >> onLayouted [
	super onLayouted.
	
	self isChecked ifTrue: [ self stepModel spotter announce: GtSpotterCandidateSelectedMoved new ]
]

{ #category : #'brick-structure-events' }
GtSpotterItemBrick >> onRemovedFrom: aBrick [
	super onRemovedFrom: aBrick.
	
	"I must not receive any announcements as soon as i'm removed from dom"
	self stepModel ifNotNil: [
		self stepModel announcer unsubscribe: self.
		self stepModel spotter announcer unsubscribe: self  ]
]

{ #category : #'event handling' }
GtSpotterItemBrick >> onSelectedChanged: anAnnouncement [

	self checkOrUncheck
]

{ #category : #'event handling' }
GtSpotterItemBrick >> onStepPopped [

	
	(self stepModel spotter steps last = self stepModel) & self isChecked ifTrue: [
		self notifySelected ]
]

{ #category : #'brick-properties-events' }
GtSpotterItemBrick >> onThemerChanged [
	super onThemerChanged.
	
	self themer spotterThemer itemNormalWidgetStyleFor: self
]

{ #category : #accessing }
GtSpotterItemBrick >> processor [
	^ self candidateLink processor
]

{ #category : #'event handling' }
GtSpotterItemBrick >> select [
	super select.
	self showActionbar
]

{ #category : #testing }
GtSpotterItemBrick >> shouldShowActionbar [
	"Return true if actionbar should be shown, false otherwise"
	<return: #Boolean>

	^ self isHovered or: [
		self isChecked or: [
			self stepModel ifNil: [ false ] ifNotNil: [ :sm | sm isSelected: self candidateLink ] ] ]
]

{ #category : #actions }
GtSpotterItemBrick >> showActionbar [
	self shouldShowActionbar
		ifFalse: [ ^ self ].

	self actionbarBrick visible: true
]

{ #category : #'morphic - events' }
GtSpotterItemBrick >> singleClick: evt [

	self stepModel select: self candidateLink dueTo: #singleClick
]

{ #category : #accessing }
GtSpotterItemBrick >> stepModel [

	^ stepModel
]

{ #category : #accessing }
GtSpotterItemBrick >> stepModel: aModel [

	stepModel := aModel.
	
	stepModel announcer when: GtSpotterSelectedCandidateChanged send: #onSelectedChanged: to: self.
	stepModel spotter announcer when: GtSpotterStepPopped send: #onStepPopped to: self.
	
	self actionbarBrick stepModel: aModel.
	
	self
		highlightQuery;
		checkOrUncheck
]

{ #category : #accessing }
GtSpotterItemBrick >> text: aString [

	self labelBrick text: aString
]

{ #category : #'event handling' }
GtSpotterItemBrick >> uncheck [
	super uncheck.
	self hideActionbar
]
