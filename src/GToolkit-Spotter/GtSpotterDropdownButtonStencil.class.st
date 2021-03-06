Class {
	#name : #GtSpotterDropdownButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'actOn',
		'tooltip',
		'valuable',
		'icon',
		'extentComputation',
		'spotterModelActions',
		'spotterElementActions'
	],
	#category : #'GToolkit-Spotter-Stencils'
}

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> actOn [
	"Return a block that receives a ${class:GtSpotterActOn}$, an acted on item, a button.
	User should call ${method:aGtSpotterActOn>>#actedUpon:}$ when an action happens"
	^ actOn 
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> actOn: aBlock [
	"Set a block that receives a ${class:GtSpotterActOn}$, an acted on item, a button.
	User should call ${method:aGtSpotterActOn>>#actedUpon:}$ when an action happens"
	actOn := aBlock
]

{ #category : #'private - actions' }
GtSpotterDropdownButtonStencil >> actOn: anAnnouncement button: aButton [
	self actOn cull: anAnnouncement cull: anAnnouncement realItem cull: aButton.

	"hide Spotter in the next Space iteration 
	to be able to open a new World tab if necessary"
	aButton enqueueTask: (BlTaskAction new action: [
		aButton fireEvent: (BrDropdownHideWish new anchor: aButton) ]).
]

{ #category : #'api - instantiation' }
GtSpotterDropdownButtonStencil >> create [
	| aButton |

	aButton := BrButton new.
	aButton
		icon: icon;
		label: self tooltip;
		look: BrGlamorousButtonWithIconLook;
		addLook: (BrGlamorousWithDropdownLook
			handle: [ BrButton new
				icon: self icon;
				label: self tooltip;
				look: BrGlamorousButtonWithIconLook 
					- BrGlamorousButtonWithLabelTooltipLook
					- BrGlamorousButtonExteriorLook ]
			content: [ self spotterElementFor: aButton ]
			lookDo: [ :aDropdownLook | aDropdownLook background: BrGlamorousColors secondaryHeaderBackgroundColor ]).
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

{ #category : #initialization }
GtSpotterDropdownButtonStencil >> initialize [
	super initialize.
	spotterModelActions := Array empty.
	spotterElementActions := Array empty.
	actOn := [ :anActOnEvent :anItem :aButton | "do nothing" ].
	icon := BrGlamorousVectorIcons search.
	tooltip := 'Search'.
	
	"Extent should be a computation block, otherwise the size in the stencil
	would only change after the recreation of the stencil.
	see https://github.com/feenkcom/gtoolkit/issues/1745"
	extentComputation := [ 600 @ 400 ].
	self receiver: GtSpotterStart selector: #new.
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

{ #category : #'api - preview' }
GtSpotterDropdownButtonStencil >> onPreviewChangedDo: aBlock [
	"Block is evaluated on preview satus changes.
	It receives the status: [ :isDisplayed | ... ]"
	self spotterModelDo: [ :aSpotter | 
		aSpotter announcer
			when: GtSpotterHidePreview, GtSpotterShowPreview
			do: [ :anEvent | aBlock value: aSpotter isPreviewVisible ] ]
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

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> spotterElementDo: aOneArgBlock [
	"Configure a ${class:GtSpotterElement}$ instance.
	Remember that the element size can be set using ${method:GtSpotterDropdownButtonStencil>>extent:}$.
	The block receives one argument [ :aSpotterElement | ]."
	spotterElementActions := spotterElementActions copyWith: aOneArgBlock
]

{ #category : #'api - instantiation' }
GtSpotterDropdownButtonStencil >> spotterElementFor: aButton [
	| aSpotterModel aSpotterElement |

	aSpotterModel := GtSpotter new initializeWith: self object.
	spotterModelActions do: [ :eachAction |
		eachAction cull: aSpotterModel ].

	aSpotterElement := GtSpotterElement new
		spotterModel: aSpotterModel;
		size: self extent.

	spotterElementActions do: [ :eachAction | 
		eachAction cull: aSpotterElement ].

	aSpotterModel announcer
		when: GtSpotterExitAnnouncement
		do: [ 
			aSpotterModel announcer unsubscribe: self.
			aButton dispatchEvent: (BrDropdownHideWish new) ].

	aSpotterModel announcer
		when: GtSpotterActOn
		do: [ :anAnnouncement |
			aSpotterModel announcer unsubscribe: self.
			self actOn: anAnnouncement button: aButton ].

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
