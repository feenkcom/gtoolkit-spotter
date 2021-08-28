Class {
	#name : 'GtSpotterClassWithAssertionsInProcessor',
	#superclass : 'Object',
	#category : 'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : 'examples' }
GtSpotterClassWithAssertionsInProcessor >> gtMockProcessorFor: aSpotterStep [
	" No Exceptions expected ! "

	<gtSearch>
	self assert: GtCurrentSpotterExceptionHandler value notNil.
	self
		assert:
			GtCurrentSpotterExceptionHandler value
				== aSpotterStep spotter exceptionHandler.
	aSpotterStep listProcessor
		priority: 1;
		allCandidates: [ self assert: GtCurrentSpotterExceptionHandler value notNil.
			self
				assert:
					GtCurrentSpotterExceptionHandler value
						== aSpotterStep spotter exceptionHandler.
			#(1 2 3) ];
		itemName: [ :item | 
			self assert: GtCurrentSpotterExceptionHandler value notNil.
			self
				assert:
					GtCurrentSpotterExceptionHandler value
						== aSpotterStep spotter exceptionHandler.
			item asString ];
		filter: GtSpotterFilterWithAssertions
]
