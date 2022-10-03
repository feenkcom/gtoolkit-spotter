Class {
	#name : #GtSpotterByScripterExamples,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples'
}

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
GtSpotterByScripterExamples >> spotterElementOnStartSampleCheckCandidates [
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
		// BrLabel;
		value: [ :aLabel | aLabel text asString ]
		equals: '10';
		play.
		
	scripter assert
		id: GtSpotterCandidateElementId index: 2;
		satisfies: [ :aCandidate |
			(aCandidate states hasState: BlElementState selected) not ];
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
GtSpotterByScripterExamples >> spotterElementOnStartWithExceptionInItemName [
	<gtExample>
	| scripter |

	scripter := self spotterElementOnStart: GtSpotterClassWithExceptionInItemName new.
	
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

	scripter := self spotterElementOnStart: GtSpotterClassWithExceptionInSearch new.
	
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
			equals: [ AssertionFailure name, ': ', GtSpotterClassWithExceptionInSearch name ];
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
			equals: [ AssertionFailure name, ': ', GtSpotterClassWithExceptionInSearch name ];
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
			equals: [ GtStreamingSpotterSearchWrongReturnError name];
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

	^ GtStreamingSpotter on: aStartObject
]
