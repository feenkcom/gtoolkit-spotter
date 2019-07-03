Class {
	#name : #GtSpotterStepsBreadcrumb,
	#superclass : #GLMBrick,
	#instVars : [
		'spotterModel',
		'items',
		'band',
		'animation'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #'adding/removing' }
GtSpotterStepsBreadcrumb >> addItem: aBrick [

	aBrick width: [ :itemBrick | self calculateItemWidth: itemBrick ].
	aBrick layout widthDependency: self.
	
	self items size = 1 ifTrue: [
		self items first labelBrick paddingLeft: self themer spotterThemer breadcrumbSeparatorWidth / 2 ].
	
	self items addLast: aBrick.
	self band addBrickBack: aBrick.
	self items do: [ :b | b wrappedBounds markWidthDirty ].
	self band doLayoutForce.
]

{ #category : #'adding/removing' }
GtSpotterStepsBreadcrumb >> addSeparator [
	|separator|
	separator := self newSeparator.
	self themer spotterThemer breadcrumbSeparatorStyleFor: separator.
	self themer spotterThemer breadcrumbSeparatorWidgetStyleFor: separator.
	self band addBrickBack: separator
]

{ #category : #accessing }
GtSpotterStepsBreadcrumb >> animation [

	^ animation
]

{ #category : #accessing }
GtSpotterStepsBreadcrumb >> band [

	^ band
]

{ #category : #accessing }
GtSpotterStepsBreadcrumb >> band: aBrick [

	band := aBrick.
	band
		useHorizontalLinearLayout;
		hShrinkWrap;
		vSpaceFill.
	
	self band data: 0.
	self addBrickBack: band.
]

{ #category : #geometry }
GtSpotterStepsBreadcrumb >> calculateItemWidth: aBrick [
	|sWidth bWidth singleWidth lastWidth|
	sWidth := self themer spotterThemer breadcrumbSeparatorWidth.
	bWidth := self width.
	lastWidth := ((aBrick labelBrick approximateWidth min: (bWidth / 2)) max: ((bWidth - ((self maxNumberOfSteps - 1) * sWidth)) / self maxNumberOfSteps)) floor.
	singleWidth := ((bWidth - lastWidth - ((self maxNumberOfSteps - 1) * sWidth)) / (self maxNumberOfSteps - 1)) floor.
	
	"width of other bricks depends on the width of the last one"
	^ aBrick isLastInOwner
		ifTrue: [
			self items size >= self maxNumberOfSteps ifTrue: [ |fullWidth delta|
				fullWidth := lastWidth + ((self maxNumberOfSteps - 1) * (sWidth + singleWidth)).
				delta := bWidth - fullWidth.
				lastWidth := lastWidth + delta ].
			lastWidth ]
		ifFalse: [ singleWidth ]
	
]

{ #category : #accessing }
GtSpotterStepsBreadcrumb >> defaultBreadcrumbHeight [

	^ self themer spotterThemer breadcrumbHeight + self themer spotterThemer breadcrumbTriangleHeight
]

{ #category : #geometry }
GtSpotterStepsBreadcrumb >> glmAnimateBrickBounds: aValue duration: anInteger callback: aBlock [

	self animation ifNotNil: #terminate.
	animation := GLMAnimation new
		linear;
		duration: anInteger;
		from: self band brickBounds left;
		to: self band brickBounds left + aValue;
		onCompleted: aBlock;
		animation: [ :b :v | b changedWith: [ b translateXTo: v asInteger; data: b brickBounds left ] ];
		animate: self band
]

{ #category : #initialization }
GtSpotterStepsBreadcrumb >> initialize [
	super initialize.
	
	self band: self newBand
]

{ #category : #testing }
GtSpotterStepsBreadcrumb >> isVisible [

	^ self items isEmpty not
]

{ #category : #accessing }
GtSpotterStepsBreadcrumb >> items [

	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : #accessing }
GtSpotterStepsBreadcrumb >> maxNumberOfSteps [
	^ 5
]

{ #category : #'instance creation' }
GtSpotterStepsBreadcrumb >> newBand [

	^ GLMBrick new
]

{ #category : #'instance creation' }
GtSpotterStepsBreadcrumb >> newSeparator [

	^ GLMBrick new
]

{ #category : #notifying }
GtSpotterStepsBreadcrumb >> notifyBreadcrumbVisibilityChanged [

	self announcer announce: GtSpotterBreadcrumbVisibilityChanged new
]

{ #category : #'brick-layout-events' }
GtSpotterStepsBreadcrumb >> onChildrenLayouted [
	super onChildrenLayouted.
	
	self band translateXTo: (self band data ifNil: [ 0 ]).
	self scrollToTheLastOne
]

{ #category : #'events-processing' }
GtSpotterStepsBreadcrumb >> onStepAdded: ann [
	|step origin previousStep selectedCandidate|
	
	self spotterModel steps size <= 1 ifTrue: [
		^ self push: (GtSpotterStepBreadcrumbItem new
						text: self spotterModel steps first origin gtDisplayString;
						stepModel: self spotterModel steps first) ].
	
	step := ann stepModel.
	previousStep := (step spotter steps at: step spotter steps size - 1).
	selectedCandidate := previousStep selected candidate.
	origin := step origin.
	
	self push: (GtSpotterStepBreadcrumbItem new
		stepModel: step;
		text: ((selectedCandidate = origin)
			ifTrue: [ (previousStep selected renderingProcessor render: selectedCandidate) labelBrick text ]
			ifFalse: [ (origin isKindOf: Collection)
				ifTrue: [ step processors first title ]
				ifFalse: [ origin gtDisplayString] ]))
]

{ #category : #'events-processing' }
GtSpotterStepsBreadcrumb >> onStepPopped [

	self pop
	
]

{ #category : #'brick-properties-events' }
GtSpotterStepsBreadcrumb >> onThemerChanged [
	super onThemerChanged.
	
	self band subbricks withIndexDo: [ :each :index | index even ifTrue: [ self themer spotterThemer breadcrumbSeparatorWidgetStyleFor: each ] ]
]

{ #category : #'adding/removing' }
GtSpotterStepsBreadcrumb >> pop [
	
	self band layoutAfter: [
		self band removeBrick: self items removeLast.
		self items size = 1 ifTrue: [
			self items first labelBrick paddingLeft: 0 ].
		self items isEmpty ifFalse: [ self popSeparator ].
		self items do: [ :b | b wrappedBounds markWidthDirty ] ].
	
	"optimization. if last item was popped we need to update root to reposition all brick,
	otherwise only I need to be updated"
	self items size = 0
		ifTrue: [ self notifyBreadcrumbVisibilityChanged ]
		ifFalse: [
			self items last showTriangle.
			self scrollToTheLastOne.
			self changed ]
]

{ #category : #'adding/removing' }
GtSpotterStepsBreadcrumb >> popSeparator [

	self band removeBrick: self band lastSubbrick
]

{ #category : #'adding/removing' }
GtSpotterStepsBreadcrumb >> push: aBrick [

	self themer spotterThemer breadcrumbItemStyleFor: aBrick.
	
	self band layoutAfter: [
		self items isEmpty ifFalse: [
			self items last hideTriangle.
			self addSeparator ].
		self addItem: aBrick ].
	
	"optimization. if first item was added we need to update root to reposition all bricks,
	otherwise only I need to be updated"
	self items size = 1
		ifTrue: [ self notifyBreadcrumbVisibilityChanged ]
		ifFalse: [
			self scrollToTheLastOne.
			self changed ].
	
]

{ #category : #geometry }
GtSpotterStepsBreadcrumb >> scrollToTheLastOne [
	|leftDelta rightDelta delta|
	self items isEmpty ifTrue: [ ^ self ].
	
	rightDelta := self globalBounds right - self band globalBounds right.
	leftDelta := self globalBounds left - self band globalBounds left.
			
	"all visible, return"
	(leftDelta = 0  and: [ self items size <= self maxNumberOfSteps ]) ifTrue: [ ^ self ].
	
	delta := (self items size <= self maxNumberOfSteps) ifTrue: [ leftDelta ] ifFalse: [ rightDelta ].
	delta := self band brickBounds left + delta - self band data.
	
	self
		glmAnimateBrickBounds: delta
		duration: 400
		callback: nil.
	
	
]

{ #category : #accessing }
GtSpotterStepsBreadcrumb >> spotterModel [
	^ spotterModel
]

{ #category : #accessing }
GtSpotterStepsBreadcrumb >> spotterModel: aSpotterModel [
	
	spotterModel := aSpotterModel.
	
	spotterModel announcer when: GtSpotterStepAdded send: #onStepAdded: to: self.
	spotterModel announcer when: GtSpotterStepRemoved send: #onStepPopped to: self.
]
