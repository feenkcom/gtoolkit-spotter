Class {
	#name : #GtSpotterProcessor,
	#superclass : #Object,
	#instVars : [
		'allFilteredCandidates',
		'priority',
		'definingMethod'
	],
	#category : #'GToolkit-Spotter-Model - Processors'
}

{ #category : #comparing }
GtSpotterProcessor >> < anOtherProcessor [ 
	"Answer whether the receiver is less than the argument."
	
	^ self priority < anOtherProcessor priority
]

{ #category : #public }
GtSpotterProcessor >> actOn: anObject for: aStep from: aSpotterElement [
	anObject gtSpotterActDefault: aStep from: aSpotterElement
]

{ #category : #public }
GtSpotterProcessor >> actOnCategory: anObject for: aStep from: aSpotterElement [
	anObject gtSpotterActDefault: aStep from: aSpotterElement
]

{ #category : #public }
GtSpotterProcessor >> allFilteredCandidates [
	^ allFilteredCandidates ifNil: [ allFilteredCandidates := OrderedCollection new ]
]

{ #category : #public }
GtSpotterProcessor >> allFilteredCandidatesDo: aBlock [
	allFilteredCandidates ifNotNil: aBlock
]

{ #category : #private }
GtSpotterProcessor >> basicContinueFilterInContext: aSpotterContext [

	" We DO NOT prepare the context since we could no longer continue producing filtered candidates. "
	(self shouldFilterInContext: aSpotterContext) ifTrue: [
		" The continue-filter only puts more items on the stream but doesn't do any filtering at all. Therefore the original collection (=result/candidates) and its size remains the same and can be reused after the continue-filter has added more items. So we do not ressign the result to #allFilteredCandidates as it is done for the regular filter-loop. #allFilteredCandidates must never be modified more than once because the next #diveIntoCategory would render an invalid set of items !!! "
		self doContinueFilterInContext: aSpotterContext ].
	aSpotterContext stream 
		performSymbol: #onAmountChanged:in:
		withArguments: { self allFilteredCandidates size . self }
]

{ #category : #private }
GtSpotterProcessor >> basicFilterInContext: aSpotterContext [
	
	self prepareProcessorInContext: aSpotterContext.
	(self shouldFilterInContext: aSpotterContext) ifTrue: [
		allFilteredCandidates := self doFilterInContext: aSpotterContext ].
	aSpotterContext stream 
		performSymbol: #onAmountChanged:in:
		withArguments: { self allFilteredCandidates size . self }
]

{ #category : #private }
GtSpotterProcessor >> continueFilterInContext: aSpotterContext [
	[ self basicContinueFilterInContext: aSpotterContext ]
		on: Error 
		do: [ :exception | 
			self exceptionHandler 
				handleException: exception 
				do: [ ('[Spotter] Exception in continuing processor <', self title asString, '>: ', exception asString) traceCr ] ]
]

{ #category : #accessing }
GtSpotterProcessor >> definingMethod [
	^ definingMethod
]

{ #category : #accessing }
GtSpotterProcessor >> definingMethod: anObject [
	definingMethod := anObject
]

{ #category : #private }
GtSpotterProcessor >> doContinueFilterInContext: aSpotterContext [
	^ aSpotterContext doContinueFilterForProcessor: self
]

{ #category : #private }
GtSpotterProcessor >> doFilterInContext: aSpotterContext [
	"override this method to:
	- add items to the stream
	- return all found items at the end"
	self subclassResponsibility
]

{ #category : #'accessing-dynamic' }
GtSpotterProcessor >> exceptionHandler [
	self flag: 'Bloc -> overrides doesNotUnderstand discarding the current exception context'.
	^ GtCurrentSpotterExceptionHandler value ifNil: [ GtSpotterExceptionHandlerNotFound signal ]
]

{ #category : #private }
GtSpotterProcessor >> filterInContext: aSpotterContext [
	[ self basicFilterInContext: aSpotterContext ]
		on: Error 
		do: [ :exception | 
			self exceptionHandler 
				handleException: exception 
				do: [ ('[Spotter] Exception in processor <', self title asString, '>: ', exception asString) traceCr ] ]
]

{ #category : #accessing }
GtSpotterProcessor >> gtDefiningMethodFor: aView [
	<gtView>
	self hasDefiningMethod ifFalse: [ ^ aView empty ].

	^ aView forward
		title: 'Method';
		priority: 2;
		object: [ self definingMethod ];
		view: #gtSourceFor:
]

{ #category : #printing }
GtSpotterProcessor >> gtDisplayOn: stream [
	stream 
		nextPutAll: 'Processor (';
		print: priority;
		nextPutAll: '): ';
		nextPutAll: self title asString
]

{ #category : #testing }
GtSpotterProcessor >> hasDefiningMethod [
	<return: #Boolean>
	^ self definingMethod isNotNil
]

{ #category : #testing }
GtSpotterProcessor >> hasFilteredCandidates [
	^ self allFilteredCandidates notEmpty
]

{ #category : #initialization }
GtSpotterProcessor >> initialize [
	super initialize.
	priority := 100
]

{ #category : #accessing }
GtSpotterProcessor >> order [
	"Return assigned spotter order used to arrange categories in spotter UI"
	<return: #Number>
	
	^ self priority
]

{ #category : #accessing }
GtSpotterProcessor >> order: aNumber [
	"Assign to processor its spotter order to arrange categories
	within spotter ui"
	
	self priority: aNumber
]

{ #category : #private }
GtSpotterProcessor >> prepareProcessorInContext: aContext [
	allFilteredCandidates := nil
]

{ #category : #accessing }
GtSpotterProcessor >> priority [
	"Return assigned spotter order used to arrange categories in spotter UI"
	<return: #Number>
	
	^ priority
]

{ #category : #accessing }
GtSpotterProcessor >> priority: aNumber [
	"Assign to processor its spotter order to arrange categories
	within spotter ui"
	priority := aNumber
]

{ #category : #testing }
GtSpotterProcessor >> shouldFilterInContext: aSpotterContext [
	^ aSpotterContext notEmpty 
		or: [ self wantsToDisplayOnEmptyQuery ]
]

{ #category : #accessing }
GtSpotterProcessor >> title [
	self subclassResponsibility
]

{ #category : #accessing }
GtSpotterProcessor >> wantsToDisplayOnEmptyQuery [
	^ true
]

{ #category : #private }
GtSpotterProcessor >> withItemsLimit: aLimit do: aBlock [
	^ aBlock value
]
