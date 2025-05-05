Class {
	#name : #GtSpotterByScripterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #accessing }
GtSpotterByScripterExamples >> defaultStepOnStart [
	<gtExample>
	<noTest>
	^ (GtSpotter on: GtWorldSpotterSearchStart new) steps anyOne
]

{ #category : #accessing }
GtSpotterByScripterExamples >> elementOnStart [
	<gtExample>
	<noTest>
	"used for documentation"
	^ self spotterElementOnStart elementWithoutParent
]

{ #category : #accessing }
GtSpotterByScripterExamples >> elementOnStartWithExceptionsInSearch [
	<gtExample>
	<noTest>
	"used for documentation"
	^ self spotterElementOnStartWithExceptionsInSearch elementWithoutParent
]

{ #category : #accessing }
GtSpotterByScripterExamples >> scripter [
	<gtExample>
	<return: #BlScripter>
	^ BlScripter new
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStart [
	<gtExample>
	<return: #BlScripter>
	^ self spotterElementOnStart: GtWorldSpotterSearchStart new
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStart: aStartObject [
	<gtExample>
	| spotter spotterElement scripter |
	
	spotter := self spotterOnStart: aStartObject.
	spotterElement := GtStreamingSpotterElement new spotter: spotter.
	scripter := self scripter.
	scripter element: spotterElement.

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartSample [
	<gtExample>
	<return: #BlScripter>
	^ self spotterElementOnStart: GtSpotterStartSample new
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartSampleActOnFirstCandidate [
	<gtExample>
	<return: #BlScripter>
	| scripter actOnEvents actOn actOnHandler |
	scripter := self spotterElementOnStartSample.

	actOnEvents := OrderedCollection new.
	actOnHandler := GtSpotterByScripterExamplesActOnHandler new
			actOnEvents: actOnEvents.

	scripter element spotter announcer weak
		when: GtSpotterObjectActOn
		send: #onActed:
		to: actOnHandler.

	scripter mouseMoveOverStep: [ :s | s id: GtSpotterCandidateElementId index: 1 ].

	scripter
		mouseMoveOverStep: [ :s | 
			s
				id: GtSpotterCandidateElementId index: 1;
				id: GtSpotterCandidateActOnButtonId ].

	scripter
		clickStep: [ :s | 
			s
				id: GtSpotterCandidateElementId index: 1;
				id: GtSpotterCandidateActOnButtonId ].

	self assert: actOnEvents size equals: 1.

	actOn := actOnEvents first.

	self assert: actOn isActedUpon equals: true.
	self assert: actOn spotterSearch title equals: 'Priority 10'.
	self assert: actOn spotterStep equals: scripter element spotter steps first.
	self assert: actOn rawObject equals: 10.

	self
		assert: actOn objectToSend
		equals: {10.
				scripter element spotter steps first.
				actOn spotterSearch}.	"raw object"	"step"	"search"
	self assert: actOn toolToSend class equals: GtInspectorTool.
	self
		assert: actOn toolToSend object
		equals: {actOn spotterSearch.
				scripter element spotter steps first.
				10.
				{10.
					scripter element spotter steps first.
					actOn spotterSearch}}.	"search"	"step"	"raw object"	"object to send"

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartSampleActOnFirstCategory [
	<gtExample>
	<return: #BlScripter>
	| scripter actOnEvents actOn actOnHandler |
	scripter := self spotterElementOnStartSample.

	actOnEvents := OrderedCollection new.
	actOnHandler := GtSpotterByScripterExamplesActOnHandler new
			actOnEvents: actOnEvents.

	scripter element spotter announcer weak
		when: GtSpotterCategoryActOn
		send: #onActed:
		to: actOnHandler.

	scripter mouseMoveOverStep: [ :s | s id: GtSpotterCategoryElementId index: 1 ].

	scripter
		mouseMoveOverStep: [ :s | 
			s
				id: GtSpotterCategoryElementId index: 1;
				id: GtSpotterCategoryActOnButtonId ].

	scripter
		clickStep: [ :s | 
			s
				id: GtSpotterCategoryElementId index: 1;
				id: GtSpotterCategoryActOnButtonId ].

	self assert: actOnEvents size equals: 1.

	actOn := actOnEvents first.

	self assert: actOn isActedUpon equals: true.
	self assert: actOn spotterSearch title equals: 'Priority 10'.
	self assert: actOn spotterStep equals: scripter element spotter steps first.

	self assert: actOn rawCategory searchQuery equals: ''.

	self
		assert: actOn objectToSend
		equals: {actOn rawCategory.
				scripter element spotter steps first.
				actOn spotterSearch}.	"raw category"	"step"	"search"

	self assert: actOn toolToSend class equals: GtInspectorTool.
	self
		assert: actOn toolToSend object
		equals: {actOn spotterSearch.
				scripter element spotter steps first.
				actOn rawCategory.
				{actOn rawCategory.
					scripter element spotter steps first.
					actOn spotterSearch}}.	"search"	"step"	"raw category"	"category to send"

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartSampleActOnSecondCandidateWithDefaultObjectActOn [
	<gtExample>
	<return: #BlScripter>
	| scripter actOnEvents actOn actOnHandler |
	scripter := self spotterElementOnStartSample.

	actOnEvents := OrderedCollection new.
	actOnHandler := GtSpotterByScripterExamplesActOnHandler new
			actOnEvents: actOnEvents.

	scripter element spotter announcer weak
		when: GtSpotterObjectActOn
		send: #onActed:
		to: actOnHandler.

	scripter mouseMoveOverStep: [ :s | s id: GtSpotterCandidateElementId index: 2 ].

	scripter
		mouseMoveOverStep: [ :s | 
			s
				id: GtSpotterCandidateElementId index: 2;
				id: GtSpotterCandidateActOnButtonId ].

	scripter
		clickStep: [ :s | 
			s
				id: GtSpotterCandidateElementId index: 2;
				id: GtSpotterCandidateActOnButtonId ].

	self assert: actOnEvents size equals: 1.

	actOn := actOnEvents first.

	self assert: actOn isActedUpon equals: true.
	self assert: actOn spotterSearch title equals: 'Priority 20'.
	self assert: actOn spotterStep equals: scripter element spotter steps first.
	self assert: actOn rawObject equals: 20.
	self assert: actOn objectToSend equals: 20.
	self assert: actOn toolToSend class equals: GtInspectorTool.
	self assert: actOn toolToSend object equals: 20.

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartSampleActOnSecondCategoryWithDefaultCategoryActOn [
	<gtExample>
	<return: #BlScripter>
	| scripter actOnEvents actOn actOnHandler |
	scripter := self spotterElementOnStartSample.

	actOnEvents := OrderedCollection new.
	actOnHandler := GtSpotterByScripterExamplesActOnHandler new
			actOnEvents: actOnEvents.

	scripter element spotter announcer weak
		when: GtSpotterCategoryActOn
		send: #onActed:
		to: actOnHandler.

	scripter mouseMoveOverStep: [ :s | s id: GtSpotterCategoryElementId index: 2 ].

	scripter
		mouseMoveOverStep: [ :s | 
			s
				id: GtSpotterCategoryElementId index: 2;
				id: GtSpotterCategoryActOnButtonId ].

	scripter
		clickStep: [ :s | 
			s
				id: GtSpotterCategoryElementId index: 2;
				id: GtSpotterCategoryActOnButtonId ].

	self assert: actOnEvents size equals: 1.

	actOn := actOnEvents first.

	self assert: actOn isActedUpon equals: true.
	self assert: actOn spotterSearch title equals: 'Priority 20'.
	self assert: actOn spotterStep equals: scripter element spotter steps first.
	self assert: actOn rawCategory searchQuery equals: ''.
	self assert: actOn objectToSend equals: actOn rawCategory.
	self assert: actOn toolToSend class equals: GtInspectorTool.
	self assert: actOn toolToSend object equals: actOn rawCategory.

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartSampleCheckCandidates [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self spotterElementOnStartSample.

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCandidateElementId index: 1;
				// BrLabel;
				value: [ :aLabel | aLabel text asString ] equals: '10' ].

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCandidateElementId index: 2;
				// BrLabel;
				value: [ :aLabel | aLabel text asString ] equals: '20' ].

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartSampleCheckCategories [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self spotterElementOnStartSample.

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCategoryElementId index: 1;
				// BrLabel;
				value: [ :aLabel | aLabel text asString ] equals: 'Priority 10 (1 / 1)' ].

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCategoryElementId index: 2;
				// BrLabel;
				value: [ :aLabel | aLabel text asString ] equals: 'Priority 20 (2 / 2)' ].

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCategoryElementId index: 3;
				// BrLabel;
				value: [ :aLabel | aLabel text asString ] equals: 'Priority 30 (3 / 3)' ].

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartSampleCheckSelection [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self spotterElementOnStartSample.

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCandidateElementId index: 1;
				satisfies: [ :aCandidate | aCandidate states hasState: BlElementState selected ] ].

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCandidateElementId index: 1;
				value: [ :aCandidate | aCandidate background ]
					equals: ((Color fromHexString: #'69ABFD') alpha: 86 / 255.0) asBlBackground ].

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCandidateElementId index: 2;
				satisfies: [ :aCandidate | (aCandidate states hasState: BlElementState selected) not ] ].

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCandidateElementId index: 2;
				value: [ :aCandidate | aCandidate background ]
					equals: Color transparent asBlBackground ].

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartWithAPIHasPreview [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self spotterElementOnStart: GtSpotterStartWithAPI new.

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCandidateElementId index: 1;
				satisfies: [ :aCandidate | aCandidate states hasState: BlElementState selected ] ].

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterPreviewElementId index: 1;
				satisfies: [ :aPreviewElement | aPreviewElement children size = 2 ] ].

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterPreviewElementId index: 1;
				on: BrLabel index: 1;
				satisfies: [ :aLabel | aLabel text asString = 'true' ] ].

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartWithExceptionInItemName [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self
			spotterElementOnStart: GtSpotterStartWithExceptionInItemName new.

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCandidateElementId index: 3;
				// GtSpotterBrokenSearchElementId;
				// BrLabel;
				value: [ :aLabel | aLabel text asString ] equals: 'ZeroDivide' ].

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartWithExceptionsInSearch [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self spotterElementOnStart: GtSpotterStartWithExceptionInSearch new.

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCategoryElementId index: 1;
				// BrLabel;
				value: [ :aLabel | aLabel text asString ] equals: 'Untitled (1 / 1)' ].

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterBrokenSearchElementId index: 1;
				// BrLabel;
				value: [ :aLabel | aLabel text asString ]
					equals: [ AssertionFailure name , ': ' , GtSpotterStartWithExceptionInSearch name ] ].

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCategoryElementId index: 2;
				// BrLabel;
				value: [ :aLabel | aLabel text asString ]
					equals: 'Search with error (1 / 1)' ].

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterBrokenSearchElementId index: 2;
				// BrLabel;
				value: [ :aLabel | aLabel text asString ]
					equals: [ AssertionFailure name , ': ' , GtSpotterStartWithExceptionInSearch name ] ].

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCategoryElementId index: 3;
				// BrLabel;
				value: [ :aLabel | aLabel text asString ]
					equals: 'Search without return (1 / 1)' ].

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterBrokenSearchElementId index: 3;
				// BrLabel;
				value: [ :aLabel | aLabel text asString ]
					equals: [ GtSpotterSearchWrongReturnError name ] ].

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartWithNilItems [
	<gtExample>
	<return: #BlScripter>
	| scripter |
	scripter := self spotterElementOnStart: GtSpotterStartWithNilItems new.

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterCategoryElementId index: 1;
				// BrLabel;
				value: [ :aLabel | aLabel text asString ] equals: 'Nil items (1 / 1)' ].

	scripter
		assertStep: [ :s | 
			s
				id: GtSpotterBrokenSearchElementId index: 1;
				// BrLabel;
				value: [ :aLabel | aLabel text asString ]
					equals: '#asAsyncStream was sent to nil' ].

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterOnStart: aStartObject [
	<gtExample>

	^ GtSpotter on: aStartObject
]
