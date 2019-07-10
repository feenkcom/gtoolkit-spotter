Class {
	#name : #GtSpotterElementExamples,
	#superclass : #GtSpotterExamples,
	#category : #'GToolkit-Spotter-Examples'
}

{ #category : #examples }
GtSpotterElementExamples >> elementOnDefaultSpotter [
	<gtExample>
	| aSpotterElement aSpotterModel |

	aSpotterElement := self emptyElement.
	aSpotterModel := self defaultSpotter.

	aSpotterElement spotterModel: aSpotterModel.

	^ aSpotterElement
]

{ #category : #examples }
GtSpotterElementExamples >> elementOnDefaultSpotterInBorderlessWindow [
	<script: 'self new elementOnDefaultSpotterInBorderlessWindow'>
	| aSpotterElement aSpace |

	aSpotterElement := self elementWithPreviewOnDefaultSpotter.

	aSpace := BlSpace new.
	aSpace root: aSpotterElement.
	aSpace borderless: true.
	aSpace show
]

{ #category : #examples }
GtSpotterElementExamples >> elementOnSpotterInDropdown [
	<gtExample>
	| aSpotterElement aSpotterModel dropdown |
	aSpotterElement := self emptyElement.
	aSpotterModel := self defaultSpotter.
	aSpotterModel announcer
		when: GtSpotterSelectedCandidateChanged
		do: [ :e | 
			((#(singleClick doubleClick keyPressed) includes: e eventType)
				and: [ true ])
				ifTrue: [ dropdown collapse ] ].
	aSpotterElement
		spotterModel: aSpotterModel;
		constraintsDo: [ :c | 
			c horizontal exact: 600.
			c vertical exact: 400 ];
		margin: (BlInsets all: 1);
		geometry: (BlRectangle cornerRadius: 4);
		yourself.
	dropdown := BrDropdown new.
	^ dropdown
		look:
			(BrGlamorousDropdownLook new
				outskirtsEmbellisher: [ :e | 
					e
						background: BrGlamorousColors lightBorderColor;
						yourself ];
				yourself);
		toggle: [ BrButton new
				look: BrGlamorousButtonWithIconLook;
				icon: BrGlamorousIcons search asElement;
				when: BlElementBackgroundChangedEvent
					do: [ :e | 
					(dropdown isExpanded
						and: [ e target background paint color
								~= BrGlamorousColors lightBorderColor ])
						ifTrue: [ e target background: BrGlamorousColors lightBorderColor ] ];
				yourself ];
		popup: [ aSpotterElement ];
		yourself
]

{ #category : #examples }
GtSpotterElementExamples >> elementOnSpotterWithOneStep [
	<gtExample>
	<noTest>
	| aSpotterElement aSpotterModel |
	
	aSpotterElement := self emptyElement.
	aSpotterModel := self spotterWithOneStep.
	
	aSpotterElement spotterModel: aSpotterModel.
	
	^ aSpotterElement
]

{ #category : #examples }
GtSpotterElementExamples >> elementOnSpotterWithTwoSteps [
	<gtExample>
	| aSpotterElement aSpotterModel |

	aSpotterElement := self emptyElement.
	aSpotterModel := self spotterWithTwoSteps.
	
	aSpotterElement spotterModel: aSpotterModel.
	
	^ aSpotterElement
]

{ #category : #examples }
GtSpotterElementExamples >> elementWithPreviewOnDefaultSpotter [
	<gtExample>
	| aSpotterElement aSpotterModel |

	aSpotterElement := GtSpotterElementWithPreview new.
	aSpotterModel := self defaultSpotter.

	aSpotterElement spotterModel: aSpotterModel.
	
	aSpotterModel showPreview.

	^ aSpotterElement
]

{ #category : #examples }
GtSpotterElementExamples >> emptyElement [
	<gtExample>
	
	^ GtSpotterElement new
]
