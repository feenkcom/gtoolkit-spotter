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
	| look |
	^ BrButton new
		aptitude:
			BrGlamorousButtonWithIconAptitude
				+
					(look := BrGlamorousWithDropdownAptitude
						stencil: [ | aSpotterElement aSpotterModel |
							aSpotterElement := self emptyElement.
							aSpotterModel := self defaultSpotter.
							aSpotterModel announcer
								when: GtSpotterActOn
								do: [ :e | 
									(#(singleClick doubleClick keyPressed) includes: e eventType)
										ifTrue: [ look hide ] ].
							BlElement new
								aptitude:
									(BrGlamorousDropdownAptitude new
										handle:
											(BrButton new
												aptitude:
													BrGlamorousButtonWithIconAptitude - BrGlamorousButtonWithLabelTooltipAptitude
														- BrGlamorousButtonExteriorAptitude;
												icon: BrGlamorousVectorIcons search;
												yourself);
										content:
											(aSpotterElement
												spotterModel: aSpotterModel;
												constraintsDo: [ :c | 
													c horizontal exact: 600.
													c vertical exact: 400 ];
												yourself);
										yourself);
								background: BrGlamorousColors secondaryHeaderBackgroundColor;
								yourself ]);
		icon: BrGlamorousVectorIcons search;
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

	aSpotterElement := GtSpotterElement new.
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
