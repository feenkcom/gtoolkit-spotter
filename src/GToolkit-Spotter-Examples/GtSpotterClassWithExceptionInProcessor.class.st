Class {
	#name : 'GtSpotterClassWithExceptionInProcessor',
	#superclass : 'Object',
	#category : 'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : 'examples' }
GtSpotterClassWithExceptionInProcessor >> gtMockProcessorFor: aSpotterStep [
	<gtSearch>
	AssertionFailure signal: self messageText	" Exception while creating the processor "
]

{ #category : 'mocks' }
GtSpotterClassWithExceptionInProcessor >> messageText [
	^ self class name
]
