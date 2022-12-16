Class {
	#name : #GtSpotterByScripterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples'
}

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
	
	^ BlScripter new
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

	^ self spotterElementOnStart: GtSpotterStartSample new
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartSampleActOnFirstCandidate [
	<gtExample>
	| scripter actOnEvents actOn |

	scripter := self spotterElementOnStartSample.
	
	actOnEvents := OrderedCollection new.
	scripter element spotter
		when: GtSpotterObjectActOn
		do: [ :anAnnouncement |
			anAnnouncement beActed.
			actOnEvents add: anAnnouncement ].
	
	scripter mouseMoveOver
		id: GtSpotterCandidateElementId index: 1;
		play.

	scripter mouseMoveOver
		id: GtSpotterCandidateElementId index: 1;
		id: GtSpotterCandidateActOnButtonId;
		play.

	scripter click
		id: GtSpotterCandidateElementId index: 1;
		id: GtSpotterCandidateActOnButtonId;
		play.

	self assert: actOnEvents size equals: 1.
	
	actOn := actOnEvents first.

	self assert: actOn isActedUpon equals: true.
	self assert: actOn spotterSearch title equals: 'Priority 10'.
	self assert: actOn spotterStep equals: scripter element spotter steps first.
	self assert: actOn rawObject equals: 10.
	
	self
		assert: actOn objectToSend
		equals: {
			"raw object"
			10 .
			"step"
			scripter element spotter steps first.
			"search"
			actOn spotterSearch }.
	self
		assert: actOn toolToSend class
		equals: GtInspectorTool.
	self
		assert: actOn toolToSend object
		equals: {
			"search"
			actOn spotterSearch.
			"step"
			scripter element spotter steps first.
			"raw object".
			10.
			"object to send"
			{
				10 .
				scripter element spotter steps first.
				actOn spotterSearch } }.
	
	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartSampleActOnFirstCategory [
	<gtExample>
	| scripter actOnEvents actOn |

	scripter := self spotterElementOnStartSample.
	
	actOnEvents := OrderedCollection new.
	scripter element spotter
		when: GtSpotterCategoryActOn
		do: [ :anAnnouncement |
			anAnnouncement beActed.
			actOnEvents add: anAnnouncement ].
	
	scripter mouseMoveOver
		id: GtSpotterCategoryElementId index: 1;
		play.

	scripter mouseMoveOver
		id: GtSpotterCategoryElementId index: 1;
		id: GtSpotterCategoryActOnButtonId;
		play.

	scripter click
		id: GtSpotterCategoryElementId index: 1;
		id: GtSpotterCategoryActOnButtonId;
		play.

	self assert: actOnEvents size equals: 1.
	
	actOn := actOnEvents first.

	self assert: actOn isActedUpon equals: true.
	self assert: actOn spotterSearch title equals: 'Priority 10'.
	self assert: actOn spotterStep equals: scripter element spotter steps first.

	self assert: actOn rawCategory searchQuery equals: ''.

	self
		assert: actOn objectToSend
		equals: {
			"raw category"
			actOn rawCategory.
			"step"
			scripter element spotter steps first.
			"search"
			actOn spotterSearch }.
	
	self
		assert: actOn toolToSend
		class equals: GtInspectorTool.
	self
		assert: actOn toolToSend object
		equals: {
			"search"
			actOn spotterSearch.
			"step"
			scripter element spotter steps first.
			"raw category"
			actOn rawCategory.
			"category to send"
			{
				actOn rawCategory.
				scripter element spotter steps first .
				actOn spotterSearch
			}
		}.

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartSampleActOnSecondCandidateWithDefaultObjectActOn [
	<gtExample>
	| scripter actOnEvents actOn |

	scripter := self spotterElementOnStartSample.
	
	actOnEvents := OrderedCollection new.
	scripter element spotter
		when: GtSpotterObjectActOn
		do: [ :anAnnouncement |
			anAnnouncement beActed.
			actOnEvents add: anAnnouncement ].
	
	scripter mouseMoveOver
		id: GtSpotterCandidateElementId index: 2;
		play.

	scripter mouseMoveOver
		id: GtSpotterCandidateElementId index: 2;
		id: GtSpotterCandidateActOnButtonId;
		play.

	scripter click
		id: GtSpotterCandidateElementId index: 2;
		id: GtSpotterCandidateActOnButtonId;
		play.

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
	| scripter actOnEvents actOn |

	scripter := self spotterElementOnStartSample.
	
	actOnEvents := OrderedCollection new.
	scripter element spotter
		when: GtSpotterCategoryActOn
		do: [ :anAnnouncement |
			anAnnouncement beActed.
			actOnEvents add: anAnnouncement ].
	
	scripter mouseMoveOver
		id: GtSpotterCategoryElementId index: 2;
		play.

	scripter mouseMoveOver
		id: GtSpotterCategoryElementId index: 2;
		id: GtSpotterCategoryActOnButtonId;
		play.

	scripter click
		id: GtSpotterCategoryElementId index: 2;
		id: GtSpotterCategoryActOnButtonId;
		play.

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
	| scripter |

	scripter := self spotterElementOnStartSample.

	scripter assert
		id: GtSpotterCandidateElementId index: 1;
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
		equals: '10';
		play.
		
	scripter assert
		id: GtSpotterCandidateElementId index: 2;
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
		equals: '20';
		play.

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartSampleCheckCategories [
	<gtExample>
	| scripter |

	scripter := self spotterElementOnStartSample.

	scripter assert
		id: GtSpotterCategoryElementId index: 1;
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
		equals: 'Priority 10 (1 / 1)';
		play.

	scripter assert
		id: GtSpotterCategoryElementId index: 2;
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
		equals: 'Priority 20 (2 / 2)';
		play.

	scripter assert
		id: GtSpotterCategoryElementId index: 3;
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
		equals: 'Priority 30 (3 / 3)';
		play.

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartSampleCheckSelection [
	<gtExample>
	| scripter |

	scripter := self spotterElementOnStartSample.

	scripter assert
		id: GtSpotterCandidateElementId index: 1;
		satisfies: [ :aCandidate |
			aCandidate states hasState: BlElementState selected ];
		play.
		
	scripter assert
		id: GtSpotterCandidateElementId index: 1;
		value: [ :aCandidate | aCandidate background ]
			equals: ((Color fromHexString: #'69ABFD') alpha: 86 / 255.0) asBlBackground;
		play.

	scripter assert
		id: GtSpotterCandidateElementId index: 2;
		satisfies: [ :aCandidate |
			(aCandidate states hasState: BlElementState selected) not ];
		play.

	scripter assert
		id: GtSpotterCandidateElementId index: 2;
		value: [ :aCandidate | aCandidate background ]
			equals: Color transparent asBlBackground;
		play.

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartWithExceptionInItemName [
	<gtExample>
	| scripter |

	scripter := self spotterElementOnStart: GtSpotterStartWithExceptionInItemName new.
	
	scripter assert
		id: GtSpotterCandidateElementId index: 3;
		// GtSpotterBrokenSearchElementId;
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
		equals: 'ZeroDivide';
		play.
	
	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartWithExceptionsInSearch [
	<gtExample>
	| scripter |

	scripter := self spotterElementOnStart: GtSpotterStartWithExceptionInSearch new.
	
	scripter assert
		id: GtSpotterCategoryElementId index: 1;
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
			equals: 'Untitled (1 / 1)';
		play.
	
	scripter assert
		id: GtSpotterBrokenSearchElementId index: 1;
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
			equals: [ AssertionFailure name, ': ', GtSpotterStartWithExceptionInSearch name ];
		play.
		
	scripter assert
		id: GtSpotterCategoryElementId index: 2;
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
			equals: 'Search with error (1 / 1)';
		play.
	
	scripter assert
		id: GtSpotterBrokenSearchElementId index: 2;
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
			equals: [ AssertionFailure name, ': ', GtSpotterStartWithExceptionInSearch name ];
		play.

	scripter assert
		id: GtSpotterCategoryElementId index: 3;
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
			equals: 'Search without return (1 / 1)';
		play.
	
	scripter assert
		id: GtSpotterBrokenSearchElementId index: 3;
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
			equals: [ GtSpotterSearchWrongReturnError name];
		play.
		
	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterElementOnStartWithNilItems [
	<gtExample>
	| scripter |
	
	scripter := self spotterElementOnStart: GtSpotterStartWithNilItems new.

	scripter assert
		id: GtSpotterCategoryElementId index: 1;
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
			equals: 'Nil items (1 / 1)';
		play.

	scripter assert
		id: GtSpotterBrokenSearchElementId index: 1;
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
		equals: '#asAsyncStream was sent to nil';
		play.

	^ scripter
]

{ #category : #accessing }
GtSpotterByScripterExamples >> spotterOnStart: aStartObject [
	<gtExample>

	^ GtSpotter on: aStartObject
]
