Class {
	#name : #GtSpotterContext,
	#superclass : #Object,
	#instVars : [
		'step',
		'stream',
		'search',
		'text',
		'textTrimmed',
		'textLowercase',
		'processor',
		'filter',
		'streamed',
		'cache',
		'continuing'
	],
	#category : 'GToolkit-Spotter-Model'
}

{ #category : #public }
GtSpotterContext >> addItem: anObject [
	self stream addObject: anObject inProcessor: self processor
]

{ #category : #public }
GtSpotterContext >> addItems: aCollection [

	self stream addObjects: aCollection inProcessor: self processor
]

{ #category : #accessing }
GtSpotterContext >> cache [
	^ cache
]

{ #category : #accessing }
GtSpotterContext >> cache: anObject [
	cache := anObject
]

{ #category : #public }
GtSpotterContext >> cacheAt: aSymbol [
	^ self cacheAt: aSymbol ifAbsent: [ nil ]
]

{ #category : #public }
GtSpotterContext >> cacheAt: aSymbol ifAbsent: aBlock [
	^ self cache at: aSymbol ifAbsent: aBlock
]

{ #category : #public }
GtSpotterContext >> cacheAt: aSymbol ifAbsentPut: aBlock [
	^ self cache at: aSymbol ifAbsentPut: aBlock
]

{ #category : #public }
GtSpotterContext >> cacheAt: aSymbol put: anObject [
	^ self cache at: aSymbol put: anObject
]

{ #category : #testing }
GtSpotterContext >> canContinue [
	 " divein / really ugly, spotter-step does not really know why it was created or where it comes from :( "
	" another hack: diveIncategory must never continue because it just streams all items from the previous step. continuing in diveInCategory would duplicate all items! " 
	^ self step event == #diveIn
		or: [ self step event isNil ]
]

{ #category : #private }
GtSpotterContext >> continueFilter [
	| processors nonEmptyProcessors |
	processors := self cache at: #processorsAndFilters ifAbsent: [ ^ self ].
	nonEmptyProcessors := processors associations select: [ :assoc | assoc key hasFilteredCandidates ].
	nonEmptyProcessors size = 1 ifFalse: [ ^ self ].
	self canContinue ifFalse: [ ^ self ].
	
	self withContinue: true do: [ 
		nonEmptyProcessors do: [ :assoc | 
			assoc key continueFilterInContext: self ] ]
]

{ #category : #accessing }
GtSpotterContext >> continuing [
	^ continuing
]

{ #category : #accessing }
GtSpotterContext >> continuing: anObject [
	continuing := anObject
]

{ #category : #'accessing-defaults' }
GtSpotterContext >> defaultCache [
	^ IdentityDictionary new 
		at: #processorsAndFilters put: (IdentityDictionary new: 100); " not a limitation, just a reasonable start size "
		at: #processorsAndStreamed put: (IdentityDictionary new: 100); " not a limitation, just a reasonable start size "
		yourself
]

{ #category : #'accessing-defaults' }
GtSpotterContext >> defaultContinuing [
	^ false
]

{ #category : #'accessing-defaults' }
GtSpotterContext >> defaultText [
	^ ''
]

{ #category : #'accessing-defaults' }
GtSpotterContext >> defaultTextLowercase [
	^ self textTrimmed asLowercase
]

{ #category : #'accessing-defaults' }
GtSpotterContext >> defaultTextTrimmed [
	^ self text trimBoth
]

{ #category : #private }
GtSpotterContext >> doContinueFilterForProcessor: aGTProcessor [
	self processor: aGTProcessor.
	self filter: ((self cache at: #processorsAndFilters) at: aGTProcessor).
	self streamed: ((self cache at: #processorsAndStreamed) at: aGTProcessor).

	^ aGTProcessor withItemsLimit: aGTProcessor continueItemsLimit do: [ filter value: self ]
]

{ #category : #private }
GtSpotterContext >> doFilter: aGTFilter forProcessor: aGTProcessor [
	| aResult |
	self processor: aGTProcessor.
	self filter: aGTFilter.
	self streamed: (OrderedCollection new: 100). " not a limitation, just a reasonable start size "
	(self cache at: #processorsAndFilters) at: aGTProcessor put: aGTFilter.
	(self cache at: #processorsAndStreamed) at: aGTProcessor put: streamed.
	self signalFilterStart.
	aResult := aGTFilter value: self.
	self signalFilterFinished.
	^ aResult
]

{ #category : #comparing }
GtSpotterContext >> equals: aContext [
	aContext ifNil: [ ^ false ].
   ^ self matches: aContext search
]

{ #category : #public }
GtSpotterContext >> exceptionHandler [
	self flag: 'Bloc -> overrides doesNotUnderstand discarding the current exception context'.
	^ GtCurrentSpotterExceptionHandler value ifNil: [ self step exceptionHandler ]
]

{ #category : #accessing }
GtSpotterContext >> filter [
	^ filter
]

{ #category : #accessing }
GtSpotterContext >> filter: anObject [
	filter := anObject
]

{ #category : #'gt-extensions' }
GtSpotterContext >> gtCacheFor: aView [
	<gtView>
	self cache ifNil: [ ^ self ].
	^ aView forward 
		title: 'Cache';
		priority: 5;
		object: [ self cache ];
		view: #gtItemsFor:
]

{ #category : #initializing }
GtSpotterContext >> initialize [
	super initialize.
	
	cache := self defaultCache.
	text := self defaultText.
	continuing := self defaultContinuing.
]

{ #category : #testing }
GtSpotterContext >> isContinuing [
	^ self continuing 
		and: [ self streamed isEmptyOrNil not 
			and: [ self canContinue ] ]
]

{ #category : #testing }
GtSpotterContext >> isEmpty [
	^ self text isNil
		or: [ self textTrimmed isEmpty ]
]

{ #category : #public }
GtSpotterContext >> itemsLimit [
	^ self processor itemsLimit
]

{ #category : #testing }
GtSpotterContext >> matches: aString [
	^ self isEmpty not
		and: [ self search = aString ]
]

{ #category : #testing }
GtSpotterContext >> notEmpty [
	^ self isEmpty not
]

{ #category : #accessing }
GtSpotterContext >> processor [
	^ processor
]

{ #category : #accessing }
GtSpotterContext >> processor: anObject [
	processor := anObject
]

{ #category : #public }
GtSpotterContext >> removeCacheAt: aSymbol [
	^ self cache removeKey: aSymbol ifAbsent: [ nil ]
]

{ #category : #initializing }
GtSpotterContext >> search [
	^ search
]

{ #category : #initializing }
GtSpotterContext >> search: anObject [
	" search stores the fully entered text (including categories) "
	search := anObject
]

{ #category : #signaling }
GtSpotterContext >> signalFilterFinished [
	GtSpotterFinishedFilterSignal new
		context: self;
		filter: self filter;
		processor: self processor;
		streamed: self streamed;
		emit
]

{ #category : #signaling }
GtSpotterContext >> signalFilterStart [
	GtSpotterStartFilterSignal new
		context: self;
		filter: self filter;
		processor: self processor;
		streamed: self streamed;
		emit
]

{ #category : #'accessing-dynamic' }
GtSpotterContext >> spotter [
	^ self step spotter
]

{ #category : #accessing }
GtSpotterContext >> step [
	^ step
]

{ #category : #accessing }
GtSpotterContext >> step: anObject [
	step := anObject
]

{ #category : #accessing }
GtSpotterContext >> stream [
	^ stream
]

{ #category : #accessing }
GtSpotterContext >> stream: anObject [
	stream := anObject
]

{ #category : #accessing }
GtSpotterContext >> streamed [
	^ streamed
]

{ #category : #accessing }
GtSpotterContext >> streamed: anObject [
	streamed := anObject
]

{ #category : #accessing }
GtSpotterContext >> text [
	^ text
]

{ #category : #accessing }
GtSpotterContext >> text: anObject [
	text := anObject ifNil: [ self defaultText ]
]

{ #category : #public }
GtSpotterContext >> textLowercase [
	^ textLowercase ifNil: [ textLowercase := self defaultTextLowercase ]
]

{ #category : #public }
GtSpotterContext >> textTrimmed [
	^ textTrimmed ifNil: [ textTrimmed := self defaultTextTrimmed ]
]

{ #category : #private }
GtSpotterContext >> withContinue: aBoolean do: aBlock [
	| previousContinuing |
	previousContinuing := continuing.
	^ [ continuing := aBoolean. aBlock value ]
		ensure: [ continuing := previousContinuing ]
]
