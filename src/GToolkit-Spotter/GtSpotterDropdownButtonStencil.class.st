Class {
	#name : #GtSpotterDropdownButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'actOn',
		'tooltip',
		'valuable',
		'extent',
		'spotterElementAction',
		'icon'
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
GtSpotterDropdownButtonStencil >> actOnHandlerWithButton: aButton [
	^ [ :anEvent | 
		self actOn cull: anEvent cull: anEvent realItem cull: aButton.
		"hide Spotter in the next Space iteration 
		to be able to open a new World tab if necessary"

		aButton enqueueTask: (BlTaskAction new action: [
			aButton fireEvent: (BrDropdownHideWish new anchor: aButton) ]) ].
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
	^ extent 
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> extent: aPoint [
	self 
		assert: [ aPoint isNotNil ]
		description: [ 'Extent must be non-nil' ].
	extent := aPoint
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
	spotterElementAction := [ :aSpotterElement | "do nothing" ].
	actOn := [ :anActOnEvent :anItem :aButton | "do nothing" ].
	icon := BrGlamorousVectorIcons search.
	tooltip := 'Search'.
	extent := 600 @ 400.
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

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> receiver: aReceiver selector: aSelector [
	valuable := GtSpotterDropdownValuableSource 
		receiver: aReceiver 
		selector: aSelector
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> spotterElementDo: aOneArgBlock [
	"Configure a ${class:GtSpotterElement}$ instance.
	Remember that the element size can be set using ${method:GtSpotterDropdownButtonStencil>>extent:}$.
	The block receives one argument [ :aSpotterElement | ]."
	spotterElementAction := aOneArgBlock
]

{ #category : #'private - instantiation' }
GtSpotterDropdownButtonStencil >> spotterElementFor: aButton [
	| aSpotterModel aSpotterElement |

	aSpotterModel := GtSpotter new initializeWith: self object.

	aSpotterElement := GtSpotterElement new
		spotterModel: aSpotterModel;
		size: self extent.

	spotterElementAction ifNotNil: [ :theAction | 
		theAction cull: aSpotterElement ].

	aSpotterModel announcer
		when: GtSpotterExitAnnouncement
		do: [ aButton dispatchEvent: (BrDropdownHideWish new) ].

	aSpotterModel announcer
		when: GtSpotterActOn
		do: (self actOnHandlerWithButton: aButton).

	^ aSpotterElement
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
