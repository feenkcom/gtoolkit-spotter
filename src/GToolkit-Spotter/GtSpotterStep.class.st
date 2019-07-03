Class {
	#name : #GtSpotterStep,
	#superclass : #Object,
	#instVars : [
		'announcer',
		'processors',
		'origin',
		'context',
		'selected',
		'stream',
		'candidates',
		'asyncTask',
		'spotter',
		'lastSearchContext',
		'event'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #example }
GtSpotterStep class >> gtExampleBasic [
	<gtExample>
	^ self new
]

{ #category : #actions }
GtSpotterStep >> actDueTo: anEventType [
	"Perform an action associated with currently selected item.
	(can be triggered by doubleClick: or keyboard Enter press)"
	
	self
		assert: [ self hasSelected ]
		description: [ 'Spotter can not perform an action due to ', anEventType asString, ' if there is no selected candidate' ].

	self spotter
		historize: self selected;
		notifyActOn: self selectedCandidate for: anEventType.
	self selectedCategory actOn: self selectedCandidate for: self
]

{ #category : #accessing }
GtSpotterStep >> addProcessor: aProcessor [

	self processors add: aProcessor
]

{ #category : #accessing }
GtSpotterStep >> announcer [

	^ announcer ifNil: [ announcer := Announcer new ]
]

{ #category : #converting }
GtSpotterStep >> asElement [
	^ GtSpotterStepElement new stepModel: self
]

{ #category : #accessing }
GtSpotterStep >> asyncTask [

	^ asyncTask ifNil: [ asyncTask := self defaultTask ]
]

{ #category : #private }
GtSpotterStep >> basicRelevantProcessorsProcess: aSpotterContext [
	self basicRelevantProcessorsProcess: aSpotterContext do: [ :processor | 
		processor filterInContext: aSpotterContext ].
	aSpotterContext continueFilter
]

{ #category : #private }
GtSpotterStep >> basicRelevantProcessorsProcess: aSpotterContext do: aBlock [
	aSpotterContext text substrings 
		detect: [ :each | each beginsWith: '#' ]
		ifFound: [ :categoryQuery | 
			| categoryQueryPrefix |
			aSpotterContext text: (aSpotterContext text copyReplaceAll: categoryQuery with: '').
			categoryQueryPrefix := categoryQuery allButFirst asLowercase.
			self processors 
				select: [ :each | 
					self 
						processor: each 
						isRelevantForQuery: categoryQueryPrefix ]
				thenDo: aBlock ]
		ifNone: [ 
			self processors do: aBlock ]
]

{ #category : #actions }
GtSpotterStep >> canDiveIn: aCandidate [
	| newFakeStep canDiveIn|
	canDiveIn := false.
	newFakeStep := self spotter newStep origin: self origin.
	self spotter
		addStep: newFakeStep
		during: [ aCandidate spotterProcessorsFor: newFakeStep.
			canDiveIn := newFakeStep processors notEmpty ].
	^ canDiveIn
]

{ #category : #actions }
GtSpotterStep >> canDiveInSelectedCandidate [

	^ self canDiveIn: self selected item
]

{ #category : #accessing }
GtSpotterStep >> candidates [

	^ candidates ifNil: [
		candidates := GtSpotterCandidates new.
		candidates announcer subscribe: GtSpotterCandidateAdded send: #onCandidateAdded to: self.
		candidates announcer subscribe: GtSpotterAllCandidatesAdded send: #onCandidateAdded to: self.
		candidates announcer subscribe: GtSpotterAllCandidatesRemoved do: [ self deselect ].
		candidates ]
]

{ #category : #processing }
GtSpotterStep >> configureProcessorsStartingAt: anIndex with: aConfigurationBlock [
	"Execute aConfigurationBlock with all processors starting at anIndex.
	(this assumes processors are stored in an OrderedCollection that captures the
	orderin which they are added to the step.)"
	
	(anIndex > self processors size) ifTrue: [ ^ self ].
	anIndex to: self processors size do: [ :processorIndex |
		aConfigurationBlock value: (self processors at: processorIndex) ]
]

{ #category : #accessing }
GtSpotterStep >> context [

	^ context ifNil: [ context := self newContextForQuery: nil ]
]

{ #category : #accessing }
GtSpotterStep >> context: aGtSpotterContext [
	context := aGtSpotterContext
]

{ #category : #'accessing - defaults' }
GtSpotterStep >> defaultStream [
	^ GtSpotterUIThreadStream new
]

{ #category : #'accessing - defaults' }
GtSpotterStep >> defaultTask [
	^ GLMAsyncTask new
]

{ #category : #selecting }
GtSpotterStep >> deselect [
	"Deselects a candidate without notifying anyone"

	selected := nil
]

{ #category : #actions }
GtSpotterStep >> diveIn [
	self diveInDueTo: #undefined
]

{ #category : #actions }
GtSpotterStep >> diveInCategory [
	"dive in category of selected candidate"
	^ self diveInCategoryDueTo: #unknown
	
]

{ #category : #actions }
GtSpotterStep >> diveInCategory: aProcessor dueTo: anEventType [
	"dive in specified aCategory"

	self spotter
		requestNextCategoryStepWith: (self candidates getProcessorLink: aProcessor) for: #diveInCategory;
		notifyDiveInCategory: aProcessor for: anEventType
]

{ #category : #actions }
GtSpotterStep >> diveInCategoryDueTo: anEventType [
	"dive in category of selected candidate"

	self diveInCategory: self selected processor dueTo: anEventType
]

{ #category : #actions }
GtSpotterStep >> diveInDueTo: anEventType [
	self canDiveInSelectedCandidate ifTrue: [ 
		self spotter
			historize: self selected;
			requestNextStepWith: self selected item for: #diveIn;
			notifyDiveIn: self selected item for: anEventType ]
]

{ #category : #actions }
GtSpotterStep >> diveOutDueTo: anEventType [
	self spotter
		requestPreviousStepFor: #diveOut;
		notifyDiveOut: self selected item
]

{ #category : #accessing }
GtSpotterStep >> event [
	^ event
]

{ #category : #accessing }
GtSpotterStep >> event: anObject [
	event := anObject
]

{ #category : #'accessing - dynamic' }
GtSpotterStep >> exceptionHandler [
	^ GTCurrentSpotterExceptionHandler value ifNil: [ self spotter exceptionHandler ]
	" #ifNil: is necessary because the sender chain of #spotterProcessorsFor:pragma: may have multiple callees outside of the exception handler (async) ... so we have to provide a global but yet easy fallback "
]

{ #category : #actions }
GtSpotterStep >> exit [

	self spotter exit
]

{ #category : #'gt-extension' }
GtSpotterStep >> gtCandidatesFor: aView [
	<gtView>

	^ self candidates gtCandidatesFor: aView
]

{ #category : #printing }
GtSpotterStep >> gtDisplayText [
	^ self origin gtDisplayText
]

{ #category : #inspecting }
GtSpotterStep >> gtInspectorProcessorsIn: composite [
	<gtInspectorPresentationOrder: 40>
	composite list
		title: 'Processors';
		display: [ self processors ];
		format: #gtDisplayString;
		when: [ self spotter notNil ]
]

{ #category : #testing }
GtSpotterStep >> hasCandidates [
	"Return true if there are any candidates in all categories,
	false otherwise"
	<return: #Boolean>
	
	^ self candidates isNotEmpty
]

{ #category : #testing }
GtSpotterStep >> hasPreviousNavigationFromClass: aClass [
	"Return true if origin of the previous step is kind of aClass.
	Return false if there is no previous step or if origin is not a kind of aClass"
	<return: #Boolean>
	
	^ self hasPreviousStep and: [
		self previousStep origin isKindOf: aClass ]
]

{ #category : #testing }
GtSpotterStep >> hasPreviousStep [
	"Return true if there is previous step,
	meaning that I am not a first step in spotter,
	false otherwise"
	<return: #Boolean>
	
	^ self spotter hasSteps
		and: [ self spotter steps first ~= self ]
]

{ #category : #testing }
GtSpotterStep >> hasSelected [
	"Return true if there is a selected candidate, false otherwise"
	<return: #Boolean>
	
	^ selected isNotNil
]

{ #category : #testing }
GtSpotterStep >> isCategorySelected: aProcessor [
	"Return true if a category assigned to aProcessor is currently selected,
	false otherwise"
	<return: #Boolean>
	
	^ self hasSelected and: [ self selected processor == aProcessor ]
]

{ #category : #'zz-deprecated' }
GtSpotterStep >> isEmpty [
	self deprecated: 'Use hasCandidates instead'.
	^ self hasCandidates not
]

{ #category : #testing }
GtSpotterStep >> isSelected: aCandidate [
	"Return true if aCandidate is currently selected,
	false otherwise"
	<return: #Boolean>
	
	^ self hasSelected and: [ self selected == aCandidate ]
]

{ #category : #accessing }
GtSpotterStep >> listProcessor [
	| processor |
	processor := GtSpotterCandidatesListProcessor new.
	self addProcessor: processor.
	^ processor
]

{ #category : #processing }
GtSpotterStep >> newContextForQuery: aString [
	^ GtSpotterContext new 
		step: self;
		stream: self stream;
		text: aString;
		search: aString;
		yourself
]

{ #category : #notifying }
GtSpotterStep >> notifySelectedCandidateChanged: aCandidate [
	
	self notifySelectedCandidateChanged: aCandidate for: #unknown
]

{ #category : #notifying }
GtSpotterStep >> notifySelectedCandidateChanged: aCandidate for: anEventType [	
	self
		assert: [ aCandidate isNotNil ]
		description: [ 'aCandidate must not be nil' ].

	self announcer announce: (GtSpotterSelectedCandidateChanged new select: aCandidate).
	self spotter notifyCandidateSelected: aCandidate for: anEventType
]

{ #category : #'event processing' }
GtSpotterStep >> onCandidateAdded [
	"Select first candidate item in the list if there is no already selected
	candidate and candidate list has at least one candidate"
	(self hasSelected or: [ self candidates isEmpty ])
		ifFalse: [ self selectFirst ]
]

{ #category : #accessing }
GtSpotterStep >> origin [

	^ origin
]

{ #category : #accessing }
GtSpotterStep >> origin: anObject [

	origin := anObject
]

{ #category : #accessing }
GtSpotterStep >> previousProcessorFrom: aCollection [
	aCollection do: [ :each | 
		each asSpotterCandidateLink processor ifNotNil: [ ^ each processor ] ]. " we assume they are all identical "
	^ GtSpotterCandidatesListProcessor new
		title: 'Items';
		filter: GTFilterSubstring;
		yourself
]

{ #category : #'accessing - dynamic' }
GtSpotterStep >> previousStep [
	"Return a spotter step before me which must exist,
	otherwise behavior is undefined."
	<return: #GtSpotterStep>
	self assert: self hasPreviousStep.
	
	^ self spotter steps at: 
			(self spotter steps indexOf: self) - 1
]

{ #category : #processing }
GtSpotterStep >> process: aString [
	"I do not accept empty queries or the same queries as before.
	If nil is passed, than an empty string will be processed. This approach is used to
	destinguish when user deletes last character in the search and when search field became
	empty after spawning new step"
	
	"no need to search for the same query"
	(self context matches: aString) ifTrue: [ ^ self ].
	self context: (self newContextForQuery: aString).
	
	" updating timestamp in a stream, to prevent candidates from old process being shown "
	self stream updateTimestamp.
	
	self asyncTask
		execute: [ :aCurrentContext |
			self spotter notifyContextChangedFrom: lastSearchContext to: self context.
			self processContext: aCurrentContext ]
		withArguments: { self context. }
		callback: [
			lastSearchContext := self context. 
			self spotter notifySearchFinishedFor: aString processors: self processors ]
		"added small delay before actual searching. It makes spotter faster :)"
		delay: 200
]

{ #category : #processing }
GtSpotterStep >> processContext: aSpotterContext [
	self spotter handleExceptionsDuring: [ 
		self stream removeAllCandidates.
		self relevantProcessorsProcess: aSpotterContext  ]
]

{ #category : #private }
GtSpotterStep >> processor: aProcessor isRelevantForQuery: aString [
	| trimmedProcessorTitle |
	trimmedProcessorTitle := aProcessor title asLowercase 
										copyReplaceAll: String space
										with: ''.
	^ trimmedProcessorTitle beginsWith: aString
]

{ #category : #accessing }
GtSpotterStep >> processors [

	^ processors ifNil: [ 
		processors := OrderedCollection new.
		self origin spotterProcessorsFor: self.
		"this is a hack. we do it here just because we need to store the
		category name in the brick after the processors have been created"
		processors do: [ :each | 				
			self candidates addProcessor: each ].
		processors ]
]

{ #category : #accessing }
GtSpotterStep >> processors: aCollection [

	processors := aCollection
]

{ #category : #'accessing - dynamic' }
GtSpotterStep >> processorsFilter [

	^ self spotter processorsFilter
]

{ #category : #private }
GtSpotterStep >> relevantProcessorsProcess: aSpotterContext [
	[ self basicRelevantProcessorsProcess: aSpotterContext ]
		on: Error
		do: [ :exception | 
			self exceptionHandler 
				handleException: exception 
				do: [ ('[Spotter] Exception in process: ', exception asString) logCr ] ]
]

{ #category : #selecting }
GtSpotterStep >> select: aCandidate [
	"Select a given candidate due to unknown reason.
	It is not recommended to use this method, unless you really need to.
	Note: use #select:dueTo: to allow better usage statistics"
	
	self select: aCandidate dueTo: #unknown
]

{ #category : #selecting }
GtSpotterStep >> select: aCandidate dueTo: anEventType [
	"Select a given candidate due to provided event type.
	A selection reason is used for statistical purposes and helps us
	better understand how users use spotter and as result improve it.
	aCandidate must not be nil.
	anEventType must not be nil"

	self
		assert: [ aCandidate isNotNil ]
		description: [ 'Candidate link must not be nil' ].

	self
		assert: [ aCandidate processor isNotNil ]
		description: [ 'Candidate must have assigned category (processor)' ].
	
	"A given candidate is already selected, do nothing"
	(self isSelected: aCandidate)
		ifTrue: [ ^ self ].

	self spotter
		after: [
			selected := aCandidate.
			self notifySelectedCandidateChanged: aCandidate for: anEventType ]
		do: [ self spotter notifyCategorySelected: self selected processor ]
		ifTrue: [ (self isCategorySelected: aCandidate processor) not ]
]

{ #category : #selecting }
GtSpotterStep >> selectFirst [
	"Select the first candidate.
	Note: there must be at least one candidate in order to select first,
	make sure to check #hasCandidates before using me"
	self
		assert: [ self candidates isNotEmpty ]
		description: [ 'There must be at least one candidate in order to select the first' ].

	self select: self candidates first
]

{ #category : #selecting }
GtSpotterStep >> selectNextCategory [
	| currentCategory nextCategory |

	currentCategory := self candidates getProcessorLinkByCandidateLink: self selected.
	nextCategory := self candidates nextProcessorLinkOf: currentCategory.
	
	self select: ((currentCategory = nextCategory)
		ifTrue: [ nextCategory tailLink ]
		ifFalse: [ nextCategory headLink ])
]

{ #category : #selecting }
GtSpotterStep >> selectNextDueTo: anEventType [
	
	self select: self selected next dueTo: anEventType
]

{ #category : #selecting }
GtSpotterStep >> selectPreviousCategory [
	|currentCategory previousCategory|
	self selected ifNil: [ ^ self ].
	
	currentCategory := self candidates getProcessorLinkByCandidateLink: self selected.
	previousCategory := self candidates previousProcessorLinkOf: currentCategory.
	
	self select: previousCategory headLink
]

{ #category : #selecting }
GtSpotterStep >> selectPreviousDueTo: anEventType [

	self select: self selected previous dueTo: anEventType
]

{ #category : #'accessing - selected' }
GtSpotterStep >> selected [
	"Return a candidate link (represented by double link) to allow fast access to
	next and previous candidate. In order to get actual candidate object behind
	the link send #candidate to it.
	selected can not be nil (always use hasSelected before using me)"
	<return: #GtSpotterCandidateLink>
	self
		assert: [ selected isNotNil ]
		description: [ 'Selected candidate can not be accessed where there is no one' ].
	
	^ selected
]

{ #category : #'accessing - selected' }
GtSpotterStep >> selectedCandidate [
	"Return an actual candidate object behind candidate link. 
	Note: Since selected link can not be accessed if there is no selected one,
	always check #hasSelected before using me"
	<return: #Object>

	^ self selected item
]

{ #category : #'accessing - selected' }
GtSpotterStep >> selectedCategory [
	"Return a category processor that produced a currently selected candidate.
	Note: Since selected link can not be accessed if there is no selected one,
	always check #hasSelected before using me"
	<return: #GtSpotterProcessor>
	
	^ self selected processor
]

{ #category : #accessing }
GtSpotterStep >> spotter [

	^ spotter
]

{ #category : #accessing }
GtSpotterStep >> spotter: aSpotter [
	spotter := aSpotter 
]

{ #category : #accessing }
GtSpotterStep >> stream [

	^ stream ifNil: [
		stream := self defaultStream.
		stream
			onAddedSelector: #add:;
			onAddedAllSelector: #addAll:;
			onRemoveSelector: #removeAllCandidatesOf:;
			receiver: self candidates.
		stream ]
]

{ #category : #actions }
GtSpotterStep >> terminateProcessors [

	self asyncTask terminate
]
