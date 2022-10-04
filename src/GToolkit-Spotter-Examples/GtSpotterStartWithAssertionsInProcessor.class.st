Class {
	#name : #GtSpotterStartWithAssertionsInProcessor,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : #examples }
GtSpotterStartWithAssertionsInProcessor >> gtMockProcessorFor: aSearch [
	" No Exceptions expected ! "

	<gtSearch>
	self assert: GtCurrentSpotterExceptionHandler value notNil.
	self
		assert: GtCurrentSpotterExceptionHandler value == aSearch spotter exceptionHandler.
	^ aSearch list
		priority: 1;
		items: [ self assert: GtCurrentSpotterExceptionHandler value notNil.
			self
				assert: GtCurrentSpotterExceptionHandler value == aSearch spotter exceptionHandler.
			#(1 2 3) ];
		itemName: [ :item | 
			self assert: GtCurrentSpotterExceptionHandler value notNil.
			self
				assert: GtCurrentSpotterExceptionHandler value == aSearch spotter exceptionHandler.
			item asString ];
		filter: GtSpotterFilterWithAssertions
]
