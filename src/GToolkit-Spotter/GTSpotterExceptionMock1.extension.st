Extension { #name : #GTSpotterExceptionMock1 }

{ #category : #'*GToolkit-Spotter' }
GTSpotterExceptionMock1 >> gtMockProcessorFor: aSpotterStep [
	<gtSearch>
	AssertionFailure signal: self messageText	" Exception while creating the processor "
]
