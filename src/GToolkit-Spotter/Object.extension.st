Extension { #name : #Object }

{ #category : #'*GToolkit-Spotter' }
Object >> gtActionSearchFor: anAction [
	<gtAction>
	| fakeStep |
	fakeStep := GtSpotter new newStep origin: self.
	self spotterProcessorsFor: fakeStep.
	fakeStep processors isEmpty ifTrue: [ ^ anAction noAction ].
	^ anAction explicit stencil: [
		| dropdown |
		dropdown := BrDropdown new.
		dropdown
			look:
				(BrGlamorousDropdownLook new
					outskirtsEmbellisher: [ :e | 
						e background: BrGlamorousColors lightBorderColor ]);
			layout: BlLinearLayout horizontal;
			constraintsDo: [ :c | 
				c horizontal fitContent.
				c vertical fitContent ];
			toggle: [ BrButton new
					look: BrGlamorousButtonWithIconLook;
					icon: BrGlamorousIcons search asElement;
					when: BlElementBackgroundChangedEvent
						do: [ :e | 
							(dropdown isExpanded
								and: [ e target background paint color
									~= BrGlamorousColors lightBorderColor ])
							ifTrue: [ e target background: BrGlamorousColors lightBorderColor ] ] ];
			popup: [ | model |
				model := GtSpotter new initializeWith: self.
				model announcer
					when: GtSpotterActOn
					do: [ :e | 
						| item |
						item := e element.
						e actedUpon: true.
						self flag: 'FIXME candidates may be wrapped for some reason'.
						[ (item isKindOf: GtSpotterCandidate) and: [ item item ~~ item ] ]
							whileTrue: [ item := item item ].
						dropdown phlow spawnObject: item ].
				GtSpotterElementWithPreview new
					spotterModel: model;
					size: 600@400;
					margin: (BlInsets all: 1);
					geometry: (BlRectangle cornerRadius: 4);
					yourself ];
			yourself ]
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterActDefault [
	^ GtInspector openOn: self
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterActDefault: aStep [
	aStep exit.
	self gtSpotterActDefault
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
						, self class name , '>: ' , exception asString) logCr ] ]
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
