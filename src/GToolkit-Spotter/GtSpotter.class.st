Class {
	#name : #GtSpotter,
	#superclass : #Object,
	#instVars : [
		'foundationOrigin',
		'steps',
		'announcer',
		'currentStep',
		'pagerModel',
		'text',
		'isPreviewVisible',
		'isShiftPressed',
		'exceptionHandler',
		'history',
		'processorsFilter'
	],
	#classInstVars : [
		'history',
		'isPreviewVisible',
		'wasOpened'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #cleanup }
GtSpotter class >> cleanUp [
	self resetHistory.
	wasOpened := false
]

{ #category : #accessing }
GtSpotter class >> dontShowPreview [

	isPreviewVisible := false
]

{ #category : #example }
GtSpotter class >> exampleInWindow [
	<sampleInstance>
	
	^ GtSpotterMorph new
		extent: 400@500;
		doLayout;
		spotterModel: self new;
		openInWindow
]

{ #category : #example }
GtSpotter class >> exampleMC [
	"self exampleMC"
	<sampleInstance>
	^ GtSpotterMorph new
		extent: 400@500;
		doLayout;
		spotterModel: (self on: MCWorkingCopy allManagers);
		openCenteredInWorld
]

{ #category : #example }
GtSpotter class >> exampleSpotterWithoutMorph [
	<sampleInstance>
	<gtExample>
	<label: 'A GtSpotter without UI'>
	
	^ self new
]

{ #category : #example }
GtSpotter class >> exampleWithPreview [
	<sampleInstance>
	^ GtSpotterMorph new
		extent: (World width / 2.5 @ (World height / 1.5)) asIntegerPoint;
		spotterModel: self new;
		showPreview;
		openCenteredInWorld
]

{ #category : #example }
GtSpotter class >> exampleWorldMenu [
	<sampleInstance>
	^ GtSpotterMorph new
		extent: 400@500;
		doLayout;
		spotterModel: (self on: World worldMenu);
		openCenteredInWorld
]

{ #category : #accessing }
GtSpotter class >> extensionsPragma [
	^ #spotterOrder:
]

{ #category : #inspecting }
GtSpotter class >> gtInspectorExtensionsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Extensions';
		display: [ self spotterExtendingMethods ];
		showOnly: 50;
		format: [ :each | each gtDisplayString ];
		filterOn: [ :text :each | each gtDisplayString includesSubstring: text caseSensitive: false ]
]

{ #category : #accessing }
GtSpotter class >> history [
	^ history ifNil: [ history := WeakOrderedCollection new ]
]

{ #category : #testing }
GtSpotter class >> isPreviewVisible [

	^ isPreviewVisible ifNil: [ isPreviewVisible := false ]
]

{ #category : #accessing }
GtSpotter class >> markOpened [

	wasOpened := true
]

{ #category : #'world menu' }
GtSpotter class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #Spotter)
		action: [ GtSpotterGlobalShortcut openGlobalSpotter ];
		keyText: 'Shift + Enter';
		order: 50;
		parent: #Tools;
		help: 'Search tool to explore Pharo system effectively.';
		iconName: #smallFindIcon
]

{ #category : #'instance creation' }
GtSpotter class >> on: anObject [
	
	^ self new foundationOrigin: anObject
]

{ #category : #accessing }
GtSpotter class >> resetHistory [
	"
	self resetHistory
	"
	^ history := nil
]

{ #category : #accessing }
GtSpotter class >> showPreview [

	isPreviewVisible := true
]

{ #category : #inspecting }
GtSpotter class >> spotterExtendingMethods [
	^(SystemNavigation default allBehaviors
		flatCollect: [ :each | 
			(Pragma allNamed: self extensionsPragma in: each) 
				collect: [ :p | p method asRingDefinition ] ])
		sorted
]

{ #category : #testing }
GtSpotter class >> wasOpened [

	^ wasOpened ifNil: [ false ]
]

{ #category : #'actions api' }
GtSpotter >> addStep: aStepModel [

	self steps add: aStepModel.
	self notifyStepAdded: aStepModel
]

{ #category : #'actions api' }
GtSpotter >> addStep: aSpotterStep during: aBlock [
	"Adds aSpotterStep without announcements,
	evaluates aBlock and removes previously added
	step after evaluation.
	May be used to determine if it is possible to dive in
	a candidate by adding a fake step to simulate dive in.
	aSpotterStep must not be nil
	aBlock must not be nil"
	self assert: aSpotterStep isNotNil.
	self assert: aBlock isNotNil.
	
	self steps add: aSpotterStep.
	aBlock ensure: [ 
		self steps remove: aSpotterStep ]
]

{ #category : #'actions api' }
GtSpotter >> after: afterBlock do: doBlock ifTrue: conditionBlock [
	|value|
	value := conditionBlock brickValue: self.
	afterBlock brickValue: self.
	value ifTrue: [ doBlock brickValue: value ]
]

{ #category : #'actions api' }
GtSpotter >> after: afterBlock do: doBlock with: withBlock [
	|value|
	value := withBlock brickValue: self.
	afterBlock brickValue: self.
	doBlock brickValue: value
]

{ #category : #notifying }
GtSpotter >> announce: anAnnouncement [
	
	self announcer announce: anAnnouncement
]

{ #category : #accessing }
GtSpotter >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #'accessing-convenience' }
GtSpotter >> beDebugging [
	self exceptionHandler: GtSpotterDebuggingExceptionHandler new
]

{ #category : #'accessing-convenience' }
GtSpotter >> beDeployment [
	self exceptionHandler: GtSpotterDeploymentExceptionHandler new
]

{ #category : #accessing }
GtSpotter >> currentStep [
	^ currentStep
		ifNil: [ self hasSteps
				ifTrue: [ currentStep := self steps last ]
				ifFalse: [ self newStep origin: self foundationOrigin ] ]
]

{ #category : #accessing }
GtSpotter >> currentStep: aStepModel [
	
	currentStep := aStepModel.
	self notifyCurrentStepChanged
]

{ #category : #'accessing-defaults' }
GtSpotter >> defaultExceptionHandler [
	^ GtSpotterDeploymentExceptionHandler new
]

{ #category : #'accessing-defaults' }
GtSpotter >> defaultPagerModel [
	^ GLMPagerModel new
]

{ #category : #'accessing-defaults' }
GtSpotter >> defaultStep [
	^ GtSpotterStep new
]

{ #category : #'actions api' }
GtSpotter >> doIt [
	| result |
	Smalltalk compiler
		silentlyDo: [ result := Smalltalk compiler evaluate: text string trimBoth ]
		exceptionDo: [:ex | ^ex ]. 
	"self exitDueTo: #doIt"
]

{ #category : #accessing }
GtSpotter >> exceptionHandler [
	^ exceptionHandler ifNil: [ exceptionHandler := self defaultExceptionHandler ]
]

{ #category : #accessing }
GtSpotter >> exceptionHandler: anObject [
	exceptionHandler := anObject
]

{ #category : #'actions api' }
GtSpotter >> exit [

	self exitDueTo: #unknown
]

{ #category : #'actions api' }
GtSpotter >> exitDueTo: anEventType [

	self notifySpotterExitFor: anEventType
]

{ #category : #filtering }
GtSpotter >> filterByMethods: aCollection [
	| filter |
	
	filter := GtSpotterMethodListProcessorFilter new.
	aCollection  do: [ :aMethod |
		filter allowProcessorsFrom: aMethod ].
	self processorsFilter: filter
		
]

{ #category : #accessing }
GtSpotter >> foundationOrigin [
	
	^ foundationOrigin ifNil: [ foundationOrigin := self ]
]

{ #category : #accessing }
GtSpotter >> foundationOrigin: anObject [
	
	foundationOrigin := anObject
]

{ #category : #'model access' }
GtSpotter >> getText [

	^ self text
]

{ #category : #printing }
GtSpotter >> gtDisplayOn: stream [

	stream nextPutAll: 'Spotter'
]

{ #category : #printing }
GtSpotter >> gtDisplaySpotterMorphOn: aComposite [
	<gtInspectorPresentationOrder: 50>
	
	aComposite morph 
		title: 'Live';
		display: [ 
			GLMBrick new 
				hSpaceFill;
				vSpaceFill;
				addMorphBack: 
					(GtSpotterMorph new
						spotterModel: self);
				yourself ]
]

{ #category : #inspecting }
GtSpotter >> gtInspectorStepsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Steps';
		display: [ self steps ];
		when: [ self steps notEmpty ]
]

{ #category : #'event handling' }
GtSpotter >> handleExceptionsDuring: aBlock [
	self exceptionHandler handleExceptionsDuring: aBlock
]

{ #category : #testing }
GtSpotter >> hasMultipleSteps [

	^ self steps size > 1
]

{ #category : #testing }
GtSpotter >> hasSelected [
	^ self hasSteps and: [ self currentStep hasSelected ]
]

{ #category : #testing }
GtSpotter >> hasSteps [
	^ 	self steps isNotEmpty
]

{ #category : #'actions api' }
GtSpotter >> hidePreview [

	self isPreviewVisible ifFalse: [ ^ self ].
	isPreviewVisible := false.
	self class dontShowPreview.
	self notifyHidePreview
	
]

{ #category : #'actions api' }
GtSpotter >> historize: target [

	(target = self or: [ target isNil ])
		ifFalse: [ 
			self history removeAllSuchThat: [ :each | each value = target value ] .
			self history addFirst: target ]
]

{ #category : #accessing }
GtSpotter >> history [
	^ history ifNil: [ self class history ]
]

{ #category : #accessing }
GtSpotter >> history: aWeakCollection [
	history := aWeakCollection
]

{ #category : #initialization }
GtSpotter >> initialize [
	super initialize.
	
	processorsFilter := GtSpotterSettingsProcessorFilter new
]

{ #category : #'actions api' }
GtSpotter >> inspectIt [
	| result |
	Smalltalk compiler
		silentlyDo: [ result := Smalltalk compiler evaluate: text string trimBoth ]
		exceptionDo: [ :ex | ^ex  ].
	result inspect.
	self exitDueTo: #inspectIt 
]

{ #category : #testing }
GtSpotter >> isEmpty [
	self deprecated: 'Use hasSteps instead'.
	^ self hasSteps not
]

{ #category : #testing }
GtSpotter >> isPreviewVisible [

	^ isPreviewVisible ifNil: [ isPreviewVisible := false ]
]

{ #category : #accessing }
GtSpotter >> isShiftPressed [

	^ isShiftPressed ifNil: [ isShiftPressed := false ]
]

{ #category : #protocol }
GtSpotter >> menu [

	^ nil
]

{ #category : #'instance creation' }
GtSpotter >> newStep [

	^ self defaultStep
		spotter: self
]

{ #category : #notifying }
GtSpotter >> notifyActOn: anObject for: anEventType [

	self announce: (GtSpotterActOn new 
		element: anObject;
		eventType: anEventType)
]

{ #category : #notifying }
GtSpotter >> notifyCandidateSelected: anObject for: anEventType [

	self announce: (GtSpotterSelectedCandidateChanged new 
		select: anObject;
		eventType: anEventType)
]

{ #category : #notifying }
GtSpotter >> notifyCategorySelected: aProcessor [

	self announce: (GtSpotterCategorySelected new category: aProcessor)
]

{ #category : #notifying }
GtSpotter >> notifyContextChangedFrom: aPreviousContext to: aCurrentContext [
	self announce: (GtSpotterContextChanged new
		previous: aPreviousContext;
		current: aCurrentContext;
		yourself)
]

{ #category : #notifying }
GtSpotter >> notifyCurrentStepChanged [

	self announce: GtSpotterCurrentStepChanged new
]

{ #category : #notifying }
GtSpotter >> notifyDiveIn: anObject for: anEventType [

	self announce: (GtSpotterDiveInElement new 
		element: anObject;
		eventType: anEventType )
]

{ #category : #notifying }
GtSpotter >> notifyDiveInCategory: aProcessor for: anEventType [

	self announce: (GtSpotterDiveInCategory new 
		category: aProcessor;
		eventType: anEventType)
]

{ #category : #notifying }
GtSpotter >> notifyDiveOut: anObject [

	self announce: (GtSpotterDiveOut new element: anObject)
]

{ #category : #notifying }
GtSpotter >> notifyHideHints [

	self announce: GtSpotterHideHints new
]

{ #category : #notifying }
GtSpotter >> notifyHidePreview [

	self announce: GtSpotterHidePreview new
]

{ #category : #notifying }
GtSpotter >> notifyRevealHints [

	self announce: GtSpotterRevealHints new
]

{ #category : #notifying }
GtSpotter >> notifySearchFinishedFor: aString processors: aCollectionOfProcessors [

	self announce: (GtSpotterSearchFinished new 
								query: aString;
								processors: aCollectionOfProcessors;
								yourself)
]

{ #category : #notifying }
GtSpotter >> notifyShowPreview [

	self announce: GtSpotterShowPreview new

	
]

{ #category : #notifying }
GtSpotter >> notifySpotterExitFor: anEventType [

	self announce: (GtSpotterExitAnnouncement new
		eventType: anEventType)
]

{ #category : #notifying }
GtSpotter >> notifyStepAdded: aStep [

	self announce: (GtSpotterStepAdded new stepModel: aStep)
]

{ #category : #notifying }
GtSpotter >> notifyStepPopped [

	self announce: GtSpotterStepPopped new
]

{ #category : #'event handling' }
GtSpotter >> onPagePopped [
	
	self steps size > 0 ifTrue: [
		self currentStep: self steps last ]
]

{ #category : #accessing }
GtSpotter >> pagerModel [

	^ pagerModel ifNil: [
		pagerModel := self defaultPagerModel defaultNumberOfVisiblePages: 1.
		pagerModel announcer when: GLMPagePoped send: #onPagePopped to: self.
		pagerModel ]
]

{ #category : #'actions api' }
GtSpotter >> popStep [

	"there always should be minimum one step left"
	(self steps size > 1)
		ifTrue: [
			self
				after: [ self steps removeLast ]
				do: [ :o | self notifyDiveOut: o ]
				with: self currentStep origin.
			self notifyStepPopped.
			"perform pane popping only after we scrolled to the penultimate pane, so user doesn't see blinking"
			self pagerModel
				scrollToPane: self steps size
				callback: [ self pagerModel popPane: false ] ]
]

{ #category : #'actions api' }
GtSpotter >> popUntil: aStep [

	[ self steps last = aStep ]
		whileFalse: [ self popStep ]
]

{ #category : #accessing }
GtSpotter >> processorsFilter [

	^ processorsFilter
]

{ #category : #accessing }
GtSpotter >> processorsFilter: aFilter [
   "Set the filter for determining whether or not processors get added to a step."

	processorsFilter := aFilter
]

{ #category : #'actions api' }
GtSpotter >> pushStep: stepModel [
	
	self addStep: stepModel.
	"updating current step"
	self currentStep: stepModel
]

{ #category : #'event handling' }
GtSpotter >> requestNextCategoryStepWith: aProcessorLink for: anEventType [
	|collection|
	
	collection := aProcessorLink processor allFilteredCandidates
		collect: [ :each | each asSpotterCandidateLink renderingProcessor: aProcessorLink ].
		
	self requestNextStepWith: collection for: anEventType
]

{ #category : #'event handling' }
GtSpotter >> requestNextStepWith: origin for: anEventType [

	text := ''.
	self pushStep: (self newStep origin: origin; event: anEventType; yourself).
	self steps last process: nil
]

{ #category : #'model access' }
GtSpotter >> setText: aText from: aView [
	"I am the main entry point for triggering a new search in the current step."
	
	self steps isEmpty
		"by default there are no steps, so we need to create one based on foundation origin"
		ifTrue: [ self addStep: ( self newStep origin: self foundationOrigin ) ].

	(aText asString isEmpty and: [ self text isEmpty not ])
		ifTrue: [ self currentStep process: nil ]
		ifFalse: [ self currentStep process: aText asString ].
	
	text := aText asString asText.
	^ true
]

{ #category : #'actions api' }
GtSpotter >> shiftPressed: aBoolean [

	self isShiftPressed = aBoolean ifTrue: [ ^ self ].
	
	isShiftPressed := aBoolean.
	
	SmalltalkImage current vm canHandleShiftPressed
		ifTrue: [ ^ isShiftPressed := false ].

	self isShiftPressed
		ifTrue: [ self notifyRevealHints ]
		ifFalse: [ self notifyHideHints ]

	
]

{ #category : #'actions api' }
GtSpotter >> showPreview [

	self isPreviewVisible ifTrue: [ ^ self ].
	isPreviewVisible := true.
	self class showPreview.
	self notifyShowPreview
	
]

{ #category : #accessing }
GtSpotter >> steps [

	^ steps ifNil: [ steps := OrderedCollection new ]
]

{ #category : #'actions api' }
GtSpotter >> terminateProcessors [

	self steps do: [ :each | each terminateProcessors ]
]

{ #category : #accessing }
GtSpotter >> text [

	^ text ifNil: [ text := '' asText ]
]

{ #category : #'actions api' }
GtSpotter >> togglePreview [

	self isPreviewVisible
		ifTrue: [ self hidePreview ]
		ifFalse: [ self showPreview ]
]
