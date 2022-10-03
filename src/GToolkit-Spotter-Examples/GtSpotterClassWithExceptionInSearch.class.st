Class {
	#name : #GtSpotterClassWithExceptionInSearch,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : #examples }
GtSpotterClassWithExceptionInSearch >> gtViewWithAssertionFor: aSpotterStep [
	<gtSearch>
	AssertionFailure signal: self messageText	" Exception while creating the processor "
]

{ #category : #examples }
GtSpotterClassWithExceptionInSearch >> gtViewWithAssertionTitleAndPriorityFor: aSearch [
	<gtSearch>
	"Exception while creating a search"
	AssertionFailure signal: self messageText.	
	
	^ aSearch list
		title: 'Search with error';
		priority: 20;
		items: [ 1 to: 10 ]
]

{ #category : #examples }
GtSpotterClassWithExceptionInSearch >> gtViewWithNoReturnFor: aSearch [
	<gtSearch>

	aSearch list
		title: 'Search without return';
		priority: 30;
		items: [ 1 to: 10 ]
]

{ #category : #mocks }
GtSpotterClassWithExceptionInSearch >> messageText [
	^ self class name
]
