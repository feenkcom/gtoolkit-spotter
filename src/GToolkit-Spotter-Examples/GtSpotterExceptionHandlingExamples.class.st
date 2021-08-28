Class {
	#name : 'GtSpotterExceptionHandlingExamples',
	#superclass : 'Object',
	#traits : 'TGtExampleAssertable',
	#classTraits : 'TGtExampleAssertable classTrait',
	#category : 'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : 'accessing' }
GtSpotterExceptionHandlingExamples >> spotterForExceptionInProcessor [
	<gtExample>
	| spotter step |
	spotter := GtSpotter new.
	spotter beDebugging.
	step := GtSpotterStep new
		spotter: spotter;
		origin: GtSpotterClassWithExceptionInProcessor new;
		yourself.
	self
		should: [ step processContext: (step newContextForQuery: 'something') ]
		raise: AssertionFailure
]

{ #category : 'accessing' }
GtSpotterExceptionHandlingExamples >> spotterForNilInCandidates [
	<gtExample>
	| spotter step |
	spotter := GtSpotter new.
	spotter beDebugging.
	step := GtSpotterStep new
		spotter: spotter;
		origin: GtSpotterClassWithNilInCandidates new;
		yourself.
	self
		should: [ step processContext: (step newContextForQuery: 'something') ]
		raise: MessageNotUnderstood
]

{ #category : 'accessing' }
GtSpotterExceptionHandlingExamples >> spotterForProcessorWithExceptionInFilter [
	<gtExample>
	| spotter step |
	spotter := GtSpotter new.
	spotter beDebugging.
	step := GtSpotterStep new
		spotter: spotter;
		origin: GtSpotterClassWithExceptionInFilter new;
		yourself.
	self
		should: [ step processContext: (step newContextForQuery: 'something') ]
		raise: ArithmeticError
]

{ #category : 'accessing' }
GtSpotterExceptionHandlingExamples >> spotterForProcessorWithExceptionInItemName [
	<gtExample>
	| spotter step |
	spotter := GtSpotter new.
	spotter beDebugging.
	step := GtSpotterStep new
		spotter: spotter;
		origin: GtSpotterClassWithExceptionInItemName new;
		yourself.
	self
		should: [ step processContext: (step newContextForQuery: 'something') ]
		raise: ZeroDivide
]

{ #category : 'accessing' }
GtSpotterExceptionHandlingExamples >> spotterWithAssertionsInProcessor [
	<gtExample>
	| spotter step |
	spotter := GtSpotter new.
	spotter beDebugging.
	step := GtSpotterStep new
		spotter: spotter;
		origin: GtSpotterClassWithAssertionsInProcessor new;
		yourself.
	^ step processContext: (step newContextForQuery: 'something')
]
