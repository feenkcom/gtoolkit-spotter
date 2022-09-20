Class {
	#name : #GtStreamingSpotterCategoryElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtStreamingWithSpotterStep',
	#classTraits : 'TGtStreamingWithSpotterStep classTrait',
	#instVars : [
		'group',
		'label',
		'actOnButton',
		'diveInButton'
	],
	#category : #'GToolkit-Spotter-Streaming-UI'
}

{ #category : #'private - event handling' }
GtStreamingSpotterCategoryElement >> actDueTo: anEventType [
	| aCategory |

	aCategory := self currentCategory.

	self spotterStep
		categoryActOn: aCategory
		search: aCategory search
		dueTo: anEventType
		from: self
]

{ #category : #'private - instance creation' }
GtStreamingSpotterCategoryElement >> currentCategory [
	^ GtStreamingSpotterCategory new
		search: group domainObject
		context: spotterStep createSearchContext
]

{ #category : #'private - event handling' }
GtStreamingSpotterCategoryElement >> diveInDueTo: anEventType [
	self spotterStep
		diveIn: self currentCategory
		dueTo: anEventType
]

{ #category : #initialization }
GtStreamingSpotterCategoryElement >> group: aGroup [
	group := aGroup.
	
	self updateLabel.
	group itemsProvider sinks first sink: self asyncSink.
	group domainObject hasCategoryActOn
		ifTrue: [ actOnButton visibility: BlVisibility visible ]
		ifFalse: [ actOnButton visibility: BlVisibility hidden ]
]

{ #category : #initialization }
GtStreamingSpotterCategoryElement >> initialize [
	| aToolbar |
	super initialize.
	
	self
		hMatchParent;
		vFitContent;
		alignCenterLeft;
		padding: (BlInsets top: 5 right: 10 bottom: 5 left: 10).
	
	label := self newCategoryLabel.
	actOnButton := self newActOnButton.
	diveInButton := self newDiveInButton.
	
	aToolbar := BrHorizontalPane new
		fitContent;
		cellSpacing: 5;
		addChildren: { diveInButton . actOnButton }.
	
	self withAsyncSinkDo: [ :anElementSink | anElementSink whenUpdate: [ self updateLabel ] ].
	
	self addChildren: { 
		label.
		aToolbar
	}.
	
	self addAptitude: BrGlamorousListItemAptitude + (BrStyleCommonAptitude new
		@ aToolbar;
		default: [ :aStyle | aStyle visibility: BlVisibility gone ];
		when: [ :aState | aState hovered or: aState selected ]
			style: [ :aStyle | aStyle visibility: BlVisibility visible ] ).
			
	self when: BlDoubleClickEvent do: [ :anEvent |
		anEvent consumed: true.
		self actDueTo: #buttonDoubleClick ]
]

{ #category : #'private - instance creation' }
GtStreamingSpotterCategoryElement >> newActOnButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons accept;
		label: 'Act on category';
		action: [ self actDueTo: #buttonClick ];
		beTinySize;
		yourself
]

{ #category : #'private - instance creation' }
GtStreamingSpotterCategoryElement >> newCategoryLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: Color gray);
		hMatchParent;
		vFitContent;
		alignCenterLeft
]

{ #category : #'private - instance creation' }
GtStreamingSpotterCategoryElement >> newDiveInButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons right;
		label: 'Dive-In to search through category';
		action: [ self diveInDueTo: #buttonClick ];
		beTinySize;
		fitContent;
		alignCenterLeft
]

{ #category : #'private - event handling' }
GtStreamingSpotterCategoryElement >> updateLabel [
	| groupTitle currentAmountOfItems isDone |

	currentAmountOfItems := group itemsProvider sinks second count.
	isDone := group itemsProvider isDone.
	
	groupTitle := String
			streamContents: [ :aStream | 
				aStream
					nextPutAll: group domainObject title;
					space;
					nextPut: $(;
					print: (currentAmountOfItems min: group itemsLimit);
					space;
					nextPut: $/;
					space;
					nextPutAll: (isDone ifTrue: [ currentAmountOfItems asString ] ifFalse: [ '...' ]);
					nextPut: $) ].

	label text: groupTitle
]
