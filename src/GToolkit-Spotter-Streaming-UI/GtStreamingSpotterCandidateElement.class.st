Class {
	#name : #GtStreamingSpotterCandidateElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtStreamingWithSpotterStep',
	#classTraits : 'TGtStreamingWithSpotterStep classTrait',
	#instVars : [
		'candidate',
		'search',
		'label',
		'actOnButton',
		'diveInButton'
	],
	#category : #'GToolkit-Spotter-Streaming-UI'
}

{ #category : #'private - event handling' }
GtStreamingSpotterCandidateElement >> actDueTo: anEventType [
	self spotterStep
		itemActOn: candidate
		search: search
		dueTo: anEventType
		from: self
]

{ #category : #initialization }
GtStreamingSpotterCandidateElement >> candidate: anObject search: aSpotterSearch [
	candidate := anObject.
	search := aSpotterSearch.
	
	label text: (aSpotterSearch itemNameFor: anObject).
	
	diveInButton asyncFuture future: (spotterStep canDiveIn: anObject).
	aSpotterSearch hasItemActOn
		ifTrue: [ actOnButton visibility: BlVisibility visible ]
		ifFalse: [ actOnButton visibility: BlVisibility hidden ]
]

{ #category : #'private - event handling' }
GtStreamingSpotterCandidateElement >> diveInDueTo: anEventType [
	self spotterStep
		diveIn: candidate
		dueTo: anEventType
]

{ #category : #initialization }
GtStreamingSpotterCandidateElement >> initialize [
	| aToolbar |
	super initialize.
	
	self
		hMatchParent;
		vFitContent;
		alignCenterLeft;
		padding: (BlInsets top: 5 right: 10 bottom: 5 left: 10).
	
	label := self newCandidateLabel.
	actOnButton := self newActOnButton.
	actOnButton visibility: BlVisibility hidden.

	diveInButton := self newDiveInButton.
	diveInButton visibility: BlVisibility hidden.
	diveInButton withAsyncFutureDo: [ :anElementFuture |
		 anElementFuture
			whenPending: [ :theButton | theButton visibility: BlVisibility hidden ];
			whenError: [ :theButton :anError | theButton visibility: BlVisibility hidden ];
			whenSuccess: [ :theButton :canDiveIn |
				canDiveIn
					ifTrue: [ theButton visibility: BlVisibility visible ]
					ifFalse: [ theButton visibility: BlVisibility hidden ] ] ].

	aToolbar := BrHorizontalPane new
		fitContent;
		cellSpacing: 5;
		addChildren: { diveInButton . actOnButton }.

	self addChildren: { 
		label.
		aToolbar
	}.
	
	self addAptitude: BrGlamorousListItemAptitude + (BrStyleCommonAptitude new
		@ aToolbar;
		default: [ :aStyle | aStyle visibility: BlVisibility gone ];
		when: [ :aState | aState hovered or: aState selected ]
			style: [ :aStyle | aStyle visibility: BlVisibility visible ] )
]

{ #category : #'private - instance creation' }
GtStreamingSpotterCandidateElement >> newActOnButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons accept;
		label: 'Act on Item';
		action: [ self actDueTo: #buttonClick ];
		beTinySize;
		yourself
]

{ #category : #'private - instance creation' }
GtStreamingSpotterCandidateElement >> newCandidateLabel [
	^ BrLabel new
		aptitude: BrGlamorousLabelAptitude;
		hMatchParent;
		vFitContent;
		alignCenterLeft
]

{ #category : #'private - instance creation' }
GtStreamingSpotterCandidateElement >> newDiveInButton [
	^ BrButton new
		aptitude: BrGlamorousButtonWithIconAptitude;
		icon: BrGlamorousVectorIcons right;
		label: 'Dive-In to Search Item Details';
		action: [ self diveInDueTo: #buttonClick ];
		beTinySize;
		fitContent;
		alignCenterLeft
]
