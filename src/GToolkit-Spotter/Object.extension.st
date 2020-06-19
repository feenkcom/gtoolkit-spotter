Extension { #name : #Object }

{ #category : #'*GToolkit-Spotter' }
Object >> gtActionSearchFor: anAction [
	<gtAction>
	| fakeStep |
	fakeStep := GtSpotter new newStep origin: self.
	self gtSpotterProcessorsFor: fakeStep.
	fakeStep processors isEmpty
		ifTrue: [ ^ anAction noAction ].
	^ anAction explicit
		stencil: [ | actionButtonElement |
			actionButtonElement := BrButton new
				icon: BrGlamorousVectorIcons search;
				label: 'Search';
				look:
					BrGlamorousButtonWithIconLook
						+
							(BrGlamorousWithDropdownLook
								stencil: [ | model look element |
									model := GtSpotter new initializeWith: self.
									model announcer
										when: GtSpotterActOn
										do: [ :e | 
											| item |
											
											item := e element.
											e actedUpon: true.
											self
												flag: 'FIXME candidates may be wrapped for some reason'.
											[ (item isKindOf: GtSpotterCandidate)
												and: [ item item ~~ item ] ]
												whileTrue: [ item := item item ].
											look hide.
											actionButtonElement phlow spawnObject: item ].
									look := BrGlamorousDropdownLook new
										handle:
											(BrButton new
												icon: BrGlamorousVectorIcons search;
												label: 'Search';
												look:
													BrGlamorousButtonWithIconLook - BrGlamorousButtonWithLabelTooltipLook
														- BrGlamorousButtonExteriorLook;
												yourself);
										content:
											(GtSpotterElement new
												spotterModel: model;
												size: 600 @ 400;
												yourself);
										yourself.
									element := BlElement new
										look: look;
										background: BrGlamorousColors secondaryHeaderBackgroundColor;
										yourself ]);
				yourself ]
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterActDefault: aStep from: aSpotterElement [
	self gtSpotterActDefaultFrom: aSpotterElement.
	"if we exit spotter before default action we will not be able to dispatch opening of new spaces
	through the space in which spotter lives"
	aStep exit
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterActDefaultFrom: aSpotterElement [
	^ GtInspector openOn: self from: aSpotterElement
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterProcessorsFor: aSpotterStep [
	<return: #Collection of: #Pragma>
	^ GtSpotterProcessorsCollector new 
		fromObject: self;
		spotterStep: aSpotterStep;
		collect
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterRePropertiesFor: aStep [
	<gtSearch>
	ReSettings spotterPlugin
		ifFalse: [ ^ self ].
	aStep listProcessor
		priority: 0;
		title: 'Renraku Properties';
		items: [ self externalProperties asArray ];
		itemName: #title;
		itemIcon: #icon;
		filter: GTFilterSubstring
]
