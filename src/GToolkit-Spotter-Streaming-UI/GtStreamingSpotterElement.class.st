Class {
	#name : #GtStreamingSpotterElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtStreamingWithSpotter',
	#classTraits : 'TGtStreamingWithSpotter classTrait',
	#instVars : [
		'headerElement',
		'stepsPager',
		'previewElement'
	],
	#category : #'GToolkit-Spotter-Streaming-UI'
}

{ #category : #private }
GtStreamingSpotterElement >> currentStepElementDo: aBlock [
	(self query // (GtStreamingSpotterStepElementId indexed: self spotter currentStepIndex)) anyOne ifNotNil: aBlock
]

{ #category : #private }
GtStreamingSpotterElement >> currentStepSelectedCandidateDo: aBlock [
	self currentStepElementDo: [ :aStepElement | aStepElement selectedCandidateDo: aBlock ]
]

{ #category : #'private - event handling' }
GtStreamingSpotterElement >> handleCategoryActOn: anEvent [
]

{ #category : #'private - event handling' }
GtStreamingSpotterElement >> handleDiveIn: anEvent [
	self currentStepSelectedCandidateDo: [ :aCandidate |
		self spotter currentStep
			diveIn: aCandidate item
			dueTo: #keyPressedPrimaryArrowRight ]
]

{ #category : #'private - event handling' }
GtStreamingSpotterElement >> handleDiveOut: anEvent [
	self spotter currentStep diveOutDueTo: #keyPressedPrimaryArrowLeft
]

{ #category : #'private - event handling' }
GtStreamingSpotterElement >> handleItemActOn: anEvent [		
	self currentStepSelectedCandidateDo: [ :aCandidate |
		self spotter currentStep
			actOn: aCandidate item
			search: aCandidate search
			dueTo: #keyPressedReturn
			from: self ]
]

{ #category : #'private - event handling' }
GtStreamingSpotterElement >> handleSelectNext: anEvent [
	self currentStepElementDo: [ :anElement | anElement selectNextItem ]
]

{ #category : #'private - event handling' }
GtStreamingSpotterElement >> handleSelectPrevious: anEvent [
	self currentStepElementDo: [ :anElement | anElement selectPreviousItem ]
]

{ #category : #initialization }
GtStreamingSpotterElement >> initialize [
	super initialize.
	
	self matchParent.
	
	self background: Color white.
	self geometry: (BlRoundedRectangleGeometry cornerRadius: 5).
	self beInSeparateCompositionLayer.
	
	headerElement := GtStreamingSpotterHeaderElement new.
	stepsPager := GtStreamingSpotterPager new.
	previewElement := GtStreamingSpotterPreviewElement new.
	
	self addChildren: {
		headerElement.
		BrHorizontalPane new
			matchParent;
			addChildren: {
				stepsPager .
				BlElement new
					background: self theme header secondaryBackgroundColor;
					constraintsDo: [ :c |
						c horizontal exact: 1.
						c vertical matchParent ].
				previewElement } }.

	self addShortcut: (BlShortcutWithAction new
		overrideChildren: true;
		combination: BlKeyCombination arrowDown;
		action: [ :anEvent :aShortcut | self handleSelectNext: anEvent ]).
		
	self addShortcut: (BlShortcutWithAction new
		overrideChildren: true;
		combination: BlKeyCombination arrowUp;
		action: [ :anEvent :aShortcut | self handleSelectPrevious: anEvent ]).

	self addShortcut: (BlShortcutWithAction new
		overrideChildren: true;
		combination: BlKeyCombination primaryArrowRight;
		action: [ :anEvent :aShortcut | self handleDiveIn: anEvent ]).

	self addShortcut: (BlShortcutWithAction new
		overrideChildren: true;
		combination: BlKeyCombination primaryArrowLeft;
		action: [ :anEvent :aShortcut | self handleDiveOut: anEvent ]).

	self addShortcut: (BlShortcutWithAction new
		overrideChildren: true;
		combination: BlKeyCombination return;
		action: [ :anEvent :aShortcut | self handleItemActOn: anEvent ]).

	self addShortcut: (BlShortcutWithAction new
		overrideChildren: true;
		combination: BlKeyCombination primaryReturn;
		action: [ :anEvent :aShortcut | self handleCategoryActOn: anEvent ]).

	self when: BlKeyDownEvent do: [ :anEvent |
		anEvent key isPrimary
			ifTrue: [ spotter switchToDebugMode ] ].

	self when: BlKeyUpEvent do: [ :anEvent |
		anEvent key isPrimary
			ifTrue: [ spotter switchToProductionMode ] ].
		
	self when: GtStreamingSpotterSelectedCandidateMaybeChanged do: [ :anEvent |
		anEvent consumed: true.
		self onSelectedCandidateMaybeChanged ]
]

{ #category : #'private - event handling' }
GtStreamingSpotterElement >> onSelectedCandidateMaybeChanged [
	self currentStepSelectedCandidateDo: [ :aCandidate |
		previewElement
			updatePreviewOf: aCandidate item
			forSearch: aCandidate search ]
]

{ #category : #'api - spotter' }
GtStreamingSpotterElement >> onSpotterChanged [
	"Is sent when a new spotter is assigned to the receiver.
	Note: #onSpotterChanged is sent before #subscribeToSpotter
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSpotterChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	headerElement spotter: spotter.
	stepsPager spotter: spotter
]
