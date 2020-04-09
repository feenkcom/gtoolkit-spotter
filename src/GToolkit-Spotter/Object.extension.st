Extension { #name : #Object }

{ #category : #'*GToolkit-Spotter' }
Object >> gtActionSearchFor: anAction [
	<gtAction>
	| fakeStep |
	fakeStep := GtSpotter new newStep origin: self.
	self spotterProcessorsFor: fakeStep.
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
													BrGlamorousButtonWithIconLook - BrGlamorousWithLabelTooltipLook
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
	"if we exit spotter before default action we will not be able to dispatch oening of new spaces
	through the space in which spotter lives"
	aStep exit
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterActDefaultFrom: aSpotterElement [
	^ GtInspector openOn: self from: aSpotterElement
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterProcessorsFor: aSpotterStep [
	"This is a utility method that collects all extensions (processors) for the current object.
	By default, it simply looks for the #spotterOrder: pragma.
	The step can decice whether or not an extension should be enabled.
	The step can also configure each extension (e.g. override any property)"
	
	^ ((Pragma 
		allNamed: #gtSearch
		from: self class 
		to: Object)
			select: [:pragma | aSpotterStep processorsFilter shouldEnableProcessorsCreateBy: pragma method])
			do: [ :pragma |
				| currentSize |
				currentSize := aSpotterStep processors size.
				self gtSpotterProcessorsFor: aSpotterStep pragma: pragma.
				aSpotterStep "configure the new processors if required"
					configureProcessorsStartingAt: currentSize + 1
					with: (aSpotterStep processorsFilter configurationBlockForProcessorsCreatedBy: pragma method)]
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterProcessorsFor: aSpotterStep pragma: aPragma [
	" if there is a problem with the definition of one or more processors, let the other processors continue to work "

	[ self perform: aPragma methodSelector with: aSpotterStep ]
		on: Error
		do: [ :exception | 
			aSpotterStep exceptionHandler
				handleException: exception
				do: [ ('[Spotter] Exception while collecting processors for <'
						, self class name , '>: ' , exception asString) traceCr ] ]
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
