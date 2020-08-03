Class {
	#name : #GtSpotterDropdownButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'actOn',
		'tooltip',
		'valuable',
		'extent',
		'spotterElementAction'
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
GtSpotterDropdownButtonStencil >> actOnHandlerWithDropdown: aDropdownLook andButton: aButton [
	^ [ :anEvent | 
		self actOn cull: anEvent cull: anEvent realItem cull: aButton.
		"hide Spotter in the next Space iteration 
		to be able to open a new World tab if necessary"
		aDropdownLook widgetDo: [ :aWidget | 
			aWidget enqueueTask: (BlTaskAction new action: [
				aDropdownLook hide ]) ] ].
]

{ #category : #'api - instantiation' }
GtSpotterDropdownButtonStencil >> create [
	| aButton |
	aButton := BrButton new.
	aButton
		icon: BrGlamorousVectorIcons search;
		label: self tooltip;
		look: BrGlamorousButtonWithIconLook;
		addLook: (BrGlamorousWithDropdownLook stencil: [ self dropdownStencilFor: aButton ]).
	^ aButton.
]

{ #category : #'private - instantiation' }
GtSpotterDropdownButtonStencil >> dropdownStencilFor: aButton [ 
	| aSpotterModel aDropdownLook |
	aSpotterModel := GtSpotter new initializeWith: self object.
	aDropdownLook := self newDropdownLookWithSpotterModel: aSpotterModel.
	aSpotterModel announcer
		when: GtSpotterExitAnnouncement
		send: #hide
		to: aDropdownLook.
	aSpotterModel announcer 
		when: GtSpotterActOn
		do: (self actOnHandlerWithDropdown: aDropdownLook andButton: aButton).
	^ BlElement new
		look: aDropdownLook;
		background: BrGlamorousColors secondaryHeaderBackgroundColor
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

{ #category : #initialization }
GtSpotterDropdownButtonStencil >> initialize [
	super initialize.
	spotterElementAction := [ :aSpotterElement | "do nothing" ].
	actOn := [ :anActOnEvent :anItem :aButton | "do nothing" ].
	tooltip := 'Search'.
	extent := 600 @ 400.
	self receiver: GtSpotterStart selector: #new.
]

{ #category : #'private - instantiation' }
GtSpotterDropdownButtonStencil >> newDropdownLookWithSpotterModel: aSpotterModel [
	| aLook aSpotterElement |
	aLook := BrGlamorousDropdownLook new
		handle: (BrButton new
			icon: BrGlamorousVectorIcons search;
			label: self tooltip;
			look: BrGlamorousButtonWithIconLook 
				- BrGlamorousButtonWithLabelTooltipLook
				- BrGlamorousButtonExteriorLook);
		content: (aSpotterElement := GtSpotterElement new
			spotterModel: aSpotterModel;
			size: self extent).
	spotterElementAction ifNotNil: [ :theAction | 
		theAction cull: aSpotterElement ].
	^ aLook
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
