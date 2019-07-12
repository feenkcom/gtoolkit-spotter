Extension { #name : #GTSpotterExceptionMock5 }

{ #category : #'*GToolkit-Spotter' }
GTSpotterExceptionMock5 >> gtMockProcessorFor: aSpotterStep [
	" No Exceptions expected ! "

	<gtSearch>
	self assert: GTCurrentSpotterExceptionHandler value notNil.
	self
		assert:
			GTCurrentSpotterExceptionHandler value
				== aSpotterStep spotter exceptionHandler.
	aSpotterStep listProcessor
		priority: 1;
		allCandidates: [ self assert: GTCurrentSpotterExceptionHandler value notNil.
			self
				assert:
					GTCurrentSpotterExceptionHandler value
						== aSpotterStep spotter exceptionHandler.
			#(1 2 3) ];
		itemName: [ :item | 
			self assert: GTCurrentSpotterExceptionHandler value notNil.
			self
				assert:
					GTCurrentSpotterExceptionHandler value
						== aSpotterStep spotter exceptionHandler.
			item asString ];
		filter: GTSpotterExceptionMock5Filter
]
