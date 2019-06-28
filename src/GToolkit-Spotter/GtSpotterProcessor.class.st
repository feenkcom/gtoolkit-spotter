Class {
	#name : #GtSpotterProcessor,
	#superclass : #Object,
	#instVars : [
		'allFilteredCandidates',
		'order'
	],
	#category : #'GToolkit-Spotter-Model - Processors'
}

{ #category : #public }
GtSpotterProcessor >> actOn: anObject for: aStep [
	anObject spotterActDefault: aStep
]

{ #category : #public }
GtSpotterProcessor >> allFilteredCandidates [
	^ allFilteredCandidates ifNil: [ allFilteredCandidates := OrderedCollection new ]
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
				do: [ ('[Spotter] Exception in continuing processor <', self title asString, '>: ', exception asString) logCr ] ]
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
	^ GTCurrentSpotterExceptionHandler value ifNil: [ GtSpotterExceptionHandlerNotFound signal ]
]

{ #category : #private }
GtSpotterProcessor >> filterInContext: aSpotterContext [
	[ self basicFilterInContext: aSpotterContext ]
		on: Error 
		do: [ :exception | 
			self exceptionHandler 
				handleException: exception 
				do: [ ('[Spotter] Exception in processor <', self title asString, '>: ', exception asString) logCr ] ]
]

{ #category : #printing }
GtSpotterProcessor >> gtDisplayOn: stream [
	stream 
		nextPutAll: 'Processor: ';
		nextPutAll: self title asString
]

{ #category : #testing }
GtSpotterProcessor >> hasFilteredCandidates [
	^ self allFilteredCandidates notEmpty
]

{ #category : #accessing }
GtSpotterProcessor >> order [
	"Return assigned spotter order used to arrange categories in spotter UI"
	<return: #Number>
	
	^ order
]

{ #category : #accessing }
GtSpotterProcessor >> order: aNumber [
	"Assign to processor its spotter order to arrange categories
	within spotter ui"
	order := aNumber
]

{ #category : #private }
GtSpotterProcessor >> prepareProcessorInContext: aContext [
	allFilteredCandidates := nil
]

{ #category : #private }
GtSpotterProcessor >> render: anObject [
	^ GtSpotterItemBrick new
		icon: (nil);
		text: (anObject gtDisplayString)
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
