Class {
	#name : #GtSpotterDropdownButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'id',
		'tooltip',
		'valuable',
		'icon',
		'extentComputation',
		'spotterModelActions',
		'spotterElementActions',
		'label',
		'objectActOn',
		'categoryActOn',
		'sizeSelector',
		'aptitudeComputation'
	],
	#category : #'GToolkit-Spotter-UI-Stencils'
}

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> actOn: aBlock [
	"Set a block that receives a ${class:GtSpotterActOn}$, an acted on item, a button.
	User should call ${method:GtSpotterActOn>>#actedUpon:}$ when an action happens"

	self objectActOn: aBlock.
	self categoryActOn: aBlock
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> aptitude [
	<return: #BrAptitude>
	^ aptitudeComputation value
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> aptitude: aBlock [
	self assert: [ aBlock isNotNil ] description: [ 'Aptitude must be non-nil' ].
	self
		assert: [ (aBlock isKindOf: BrAptitude) not ]
		description: [ 'Aptitude must be computed, not instantiated in advance' ].

	aptitudeComputation := aBlock
]

{ #category : #accessing }
GtSpotterDropdownButtonStencil >> beHugeSize [
	sizeSelector := #beHugeSize
]

{ #category : #accessing }
GtSpotterDropdownButtonStencil >> beLargeSize [
	sizeSelector := #beLargeSize
]

{ #category : #accessing }
GtSpotterDropdownButtonStencil >> beMiniSize [
	sizeSelector := #beMiniSize
]

{ #category : #accessing }
GtSpotterDropdownButtonStencil >> beNoneSize [
	sizeSelector := #beNoneSize
]

{ #category : #accessing }
GtSpotterDropdownButtonStencil >> beNormalSize [
	sizeSelector := #beNormalSize
]

{ #category : #accessing }
GtSpotterDropdownButtonStencil >> beSmallSize [
	sizeSelector := #beSmallSize
]

{ #category : #accessing }
GtSpotterDropdownButtonStencil >> beTinySize [
	sizeSelector := #beTinySize
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> categoryActOn: aBlock [
	"Set a block that receives a ${class:GtSpotterCategoryActOn}$, an acted-on category, a button.
	User should call ${method:GtSpotterActOn>>#beActed}$ when an action happens"

	categoryActOn := aBlock
]

{ #category : #'api - instantiation' }
GtSpotterDropdownButtonStencil >> configureButtonWithIconLabelAndTooltip: aButton [
	(self icon isNil and: [ self label isNil ])
		ifTrue: [ aButton icon: BrGlamorousVectorIcons search.
			self tooltip
				ifNotNil: [ aButton label: self tooltip ]
				ifNil: [ aButton label: 'Search' ].
			self aptitude
				ifNotNil: [ :anAptitude | aButton aptitude: anAptitude ]
				ifNil: [ aButton aptitude: BrGlamorousButtonWithIconAptitude ].
			^ aButton ].

	(self icon isNil and: [ self label isNotNil ])
		ifTrue: [ aButton label: self label.
			self aptitude
				ifNotNil: [ :anAptitude | aButton aptitude: anAptitude ]
				ifNil: [ aButton aptitude: BrGlamorousButtonWithLabelAptitude ].
			^ aButton ].

	(self icon isNotNil and: [ self label isNil ])
		ifTrue: [ aButton icon: self icon.
			self tooltip
				ifNotNil: [ aButton label: self tooltip ]
				ifNil: [ aButton label: 'Search' ].
			self aptitude
				ifNotNil: [ :anAptitude | aButton aptitude: anAptitude ]
				ifNil: [ aButton aptitude: BrGlamorousButtonWithIconAptitude ].
			^ aButton ].

	(self icon isNotNil and: [ self label isNotNil ])
		ifTrue: [ aButton
				icon: self icon;
				label: self label.
			self aptitude
				ifNotNil: [ :anAptitude | aButton aptitude: anAptitude ]
				ifNil: [ aButton aptitude: BrGlamorousButtonWithIconAndLabelAptitude ].
			^ aButton ]
]

{ #category : #'api - instantiation' }
GtSpotterDropdownButtonStencil >> create [
	^ self createNew
]

{ #category : #'api - instantiation' }
GtSpotterDropdownButtonStencil >> createBasicButton [
	| aButton |
	aButton := BrButton new.

	self configureButtonWithIconLabelAndTooltip: aButton.

	aButton perform: self sizeSelector.

	^ aButton
]

{ #category : #'api - instantiation' }
GtSpotterDropdownButtonStencil >> createButtonWithTooltip [

	| aButton |
	aButton := self createBasicButton.

	self label ifNotNil: [ 
		self tooltip ifNotNil: [ 
			aButton addAptitude:
				(BrGlamorousWithLabelTooltipAptitude new text: self tooltip) ] ].

	^ aButton
]

{ #category : #'api - instantiation' }
GtSpotterDropdownButtonStencil >> createHandleButton [

	| aButton |
	aButton := self createBasicButton.

	aButton aptitude - BrGlamorousButtonWithLabelTooltipAptitude
	- BrGlamorousButtonExteriorAptitude.

	^ aButton
]

{ #category : #'api - instantiation' }
GtSpotterDropdownButtonStencil >> createNew [
	| aButton |
	aButton := self createButtonWithTooltip.
	aButton
		id: id;
		addAptitude: (BrGlamorousWithExplicitDropdownAptitude
				handle: [ self createHandleButton ]
				content: [ (self spotterElementFor: aButton)
						addAptitude: (BrGlamorousMenuResizableAptitude new
								whenResizedDo: [ :anEvent | 
									anEvent resizeTarget
										ifNotNil: [ :anElement | 
											anElement
												fireEvent: (GtSpotterResizedEvent new
														extent: anEvent extent;
														resizeTarget: anElement) ] ]) ]
				containerDo: [ :anElement | anElement background: BrGlamorousColors secondaryHeaderBackgroundColor ]).
	^ aButton
]

{ #category : #'api - instantiation' }
GtSpotterDropdownButtonStencil >> createOld [
	| aButton |
	aButton := self createButtonWithTooltip.
	aButton
		id: id;
		addAptitude: ((BrGlamorousWithDropdownAptitude
				handle: [ self createHandleButton ]
				content: [ self spotterElementFor: aButton ]
				aptitudeDo: [ :aDropdownLook | aDropdownLook background: BrGlamorousColors secondaryHeaderBackgroundColor ])
				preferredExtent: self extent 
					+ (0@24); "Handle height - this fixed value is fine
					for now as we place dropdowns either below and above 
					the handle element. If we include also left and right
					dropdown placements, we will have to rework this part."
				whenResizedDo: [ :anEvent | 
					anEvent resizeTarget ifNotNil: [ :anElement |
						anElement fireEvent: (GtSpotterResizedEvent new
							extent: anEvent extent;
							resizeTarget: anElement) ] ]).
	^ aButton
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> extent [
	<return: #Point>

	^ extentComputation value
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> extent: aPointOrBlock [
	self 
		assert: [ aPointOrBlock isNotNil ]
		description: [ 'Extent must be non-nil' ].

	extentComputation := aPointOrBlock
]

{ #category : #'api - preview' }
GtSpotterDropdownButtonStencil >> hidePreview [
	self spotterModelDo: [ :aSpotter | aSpotter hidePreview ]
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> icon [
	^ icon
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> icon: anIcon [
	icon := anIcon
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> id [
	<return: #BlElementId>

	^ id
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> id: aBlElementId [
	id := aBlElementId
]

{ #category : #initialization }
GtSpotterDropdownButtonStencil >> initialize [
	super initialize.
	
	id := BlElementId noId.
	spotterModelActions := Array empty.
	spotterElementActions := Array empty.
	objectActOn := [ :anActOnEvent :anItem :aButton | "do nothing" ].
	categoryActOn := [ :anActOnEvent :anItem :aButton | "do nothing" ].
	icon := BrGlamorousVectorIcons search.
	tooltip := 'Search'.
	self beNormalSize.
	aptitudeComputation := [ nil ].
	
	"Extent should be a computation block, otherwise the size in the stencil
	would only change after the recreation of the stencil.
	see https://github.com/feenkcom/gtoolkit/issues/1745"
	extentComputation := [ 600 @ 400 ].
	self receiver: GtSpotterStart selector: #new.
]

{ #category : #accessing }
GtSpotterDropdownButtonStencil >> label [

	^ label
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> label: aString [

	label := aString
]

{ #category : #'private - accessing' }
GtSpotterDropdownButtonStencil >> object [
	"Return an object on which a Spotter search starts"
	^ valuable value
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> object: anObject [ 
	"Set an object on which a Spotter search starts"
	valuable := GtSpotterDropdownObjectSource object: anObject
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> objectActOn: aBlock [
	"Set a block that receives a ${class:GtSpotterObjectActOn}$, an acted on item, a button.
	User should call ${method:GtSpotterActOn>>#beActed}$ when an action happens"

	objectActOn := aBlock
]

{ #category : #'api - preview' }
GtSpotterDropdownButtonStencil >> onPreviewChangedDo: aBlock [
	"Block is evaluated on preview satus changes.
	It receives the status: [ :isDisplayed | ... ]"

	self
		deprecated: 'Use GtSpotterDropdownButtonStencil>>#onPreviewChangedSend:to:'
		on: '14 Apr 2023'
		in: 'GToolkit DEV v0.8.2710'.

	self error: 'Use GtSpotterDropdownButtonStencil>>#onPreviewChangedSend:to:'
]

{ #category : #'api - preview' }
GtSpotterDropdownButtonStencil >> onPreviewChangedSend: aSelector to: aReceiver [
	"Block is evaluated on preview satus changes.
	It receives the announcement: [ :anAnnouncement | anAnnouncement shouldShowPreview ].
	anAnnouncement shouldShowPreview returns a boolean value"
	self spotterModelDo: [ :aSpotter | 
		aSpotter announcer weak
			when: GtSpotterPreviewModeChanged
			send: aSelector 
			to: aReceiver ]
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> receiver: aReceiver selector: aSelector [
	valuable := GtSpotterDropdownValuableSource 
		receiver: aReceiver 
		selector: aSelector
]

{ #category : #'api - preview' }
GtSpotterDropdownButtonStencil >> showPreview [
	self spotterModelDo: [ :aSpotter | aSpotter showPreview ]
]

{ #category : #'api - preview' }
GtSpotterDropdownButtonStencil >> showPreview: aValuable [
	"Valuable must return a boolean value.
	true  = show preview
	false = hide preview"
	self spotterModelDo: [ :aSpotter | aSpotter showPreview: aValuable value ]
]

{ #category : #'api - instantiation' }
GtSpotterDropdownButtonStencil >> sizeSelector [
	^ sizeSelector
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> spotterElementDo: aOneArgBlock [
	"Configure a ${class:GtSpotterElement}$ instance.
	Remember that the element size can be set using ${method:GtSpotterDropdownButtonStencil>>extent:}$.
	The block receives one argument [ :aSpotterElement | ]."
	spotterElementActions := spotterElementActions copyWith: aOneArgBlock
]

{ #category : #'api - instantiation' }
GtSpotterDropdownButtonStencil >> spotterElementFor: aButton [
	| aSpotterModel aSpotterElement aHandler |

	aSpotterModel := GtSpotter on: self object.

	spotterModelActions do: [ :eachAction |
		eachAction cull: aSpotterModel ].

	aSpotterElement := GtStreamingSpotterElement new
		spotter: aSpotterModel;
		exact: self extent.

	spotterElementActions do: [ :eachAction | 
		eachAction cull: aSpotterElement ].

	aSpotterElement
		when: GtPhlowObjectToSpawn
		do: [ :anEvent |
			aButton phlow spawnPreviousEvent: anEvent ].

	(aSpotterElement addShortcut: (BlShortcutWithAction new
		overrideChildren: true;
		combination: BlKeyCombination escape;
		action: [ aButton dispatchEvent: BrDropdownHideWish new ])).

	aHandler := GtSpotterDropdownButtonActOnHandler new 
		spotterModel: aSpotterModel;
		spotterElement: aSpotterElement;
		button: aButton;
		objectActOn: objectActOn;
		categoryActOn: categoryActOn;
		install.

	^ aSpotterElement
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> spotterModelDo: aOneArgBlock [
	"Configure a ${class:GtSpotter}$ instance.
	The block receives one argument [ :aSpotter | ]."
	spotterModelActions := spotterModelActions copyWith: aOneArgBlock
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> tooltip [
	^ tooltip
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> tooltip: aString [
	tooltip := aString
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> valuable: aValuable [
	"Set a valuable on which a Spotter search starts"
	valuable := GtSpotterDropdownValuableSource valuable: aValuable
]
