Class {
	#name : #GtStreamingSpotterBrokenSearchElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtStreamingWithSpotterStep',
	#classTraits : 'TGtStreamingWithSpotterStep classTrait',
	#instVars : [
		'search',
		'label',
		'debugButton',
		'browseButton'
	],
	#category : #'GToolkit-Spotter-Streaming-UI'
}

{ #category : #'private - event handling' }
GtStreamingSpotterBrokenSearchElement >> browseDueTo: anEventType [
	((GtCoder forMethod: search definingMethod) 
		openInPagerFrom: self)
			maximized
]

{ #category : #'private - event handling' }
GtStreamingSpotterBrokenSearchElement >> debugDueTo: anEventType [
	[ 
	  UIManager default
		  gtDebugProcess: Processor activeProcess
		  context: (search error signalerContext ifNil: [ search error signalContext ])
		  label: search error description
		  fullView: true
		  notification: nil ] forkNamed: 'Debug'
]

{ #category : #initialization }
GtStreamingSpotterBrokenSearchElement >> initialize [
	| aToolbar |
	super initialize.
	
	self
		hMatchParent;
		vFitContent;
		alignCenterLeft;
		padding: (BlInsets top: 5 right: 10 bottom: 5 left: 10).
	
	label := self newErrorLabel.
	browseButton := self newBrowseButton.
	debugButton := self newDebugButton.

	aToolbar := BrHorizontalPane new
		fitContent;
		cellSpacing: 5;
		addChildren: { debugButton . browseButton }.

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
		self debugDueTo: #buttonDoubleClick ]
]

{ #category : #'private - instance creation' }
GtStreamingSpotterBrokenSearchElement >> newBrowseButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons browse;
		label: 'Browse a defining method';
		action: [ self browseDueTo: #buttonClick ];
		beTinySize;
		yourself
]

{ #category : #'private - instance creation' }
GtStreamingSpotterBrokenSearchElement >> newDebugButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons debug;
		label: 'Debug in a Post-Mortem debugger';
		action: [ self debugDueTo: #buttonClick ];
		beTinySize;
		fitContent;
		alignCenterLeft
]

{ #category : #'private - instance creation' }
GtStreamingSpotterBrokenSearchElement >> newErrorLabel [
	^ BrLabel new
		aptitude: (BrGlamorousLabelAptitude new foreground: BrGlamorousColors linkWithErrorColor);
		hMatchParent;
		vFitContent;
		alignCenterLeft
]

{ #category : #accessing }
GtStreamingSpotterBrokenSearchElement >> search [

	^ search
]

{ #category : #accessing }
GtStreamingSpotterBrokenSearchElement >> search: aBrokenSearch [
	search := aBrokenSearch.
	label text: aBrokenSearch error printString
]