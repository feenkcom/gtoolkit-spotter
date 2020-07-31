Class {
	#name : #GtSpotterDropdownButtonStencil,
	#superclass : #BrStencil,
	#instVars : [
		'object',
		'actOn',
		'tooltip'
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
		aDropdownLook hide ].
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
		when: GtSpotterActOn
		do: (self actOnHandlerWithDropdown: aDropdownLook andButton: aButton).
	^ BlElement new
		look: aDropdownLook;
		background: BrGlamorousColors secondaryHeaderBackgroundColor
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> extent [
	^ 600 @ 400
]

{ #category : #initialization }
GtSpotterDropdownButtonStencil >> initialize [
	super initialize.
	object := GtSpotterStart new.
	actOn := [ :anActOnEvent :anItem :aButton | "do nothing" ].
	tooltip := 'Search'.
]

{ #category : #'private - instantiation' }
GtSpotterDropdownButtonStencil >> newDropdownLookWithSpotterModel: aSpotterModel [
	^ BrGlamorousDropdownLook new
		handle: (BrButton new
			icon: BrGlamorousVectorIcons search;
			label: self tooltip;
			look: BrGlamorousButtonWithIconLook 
				- BrGlamorousButtonWithLabelTooltipLook
				- BrGlamorousButtonExteriorLook);
		content: (GtSpotterElement new
			spotterModel: aSpotterModel;
			size: self extent)
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> object [
	"Return an object on which a Spotter search starts"
	^ object
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> object: anObject [
	"Set an object on which a Spotter search starts"
	object := anObject
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> tooltip [
	^ tooltip
]

{ #category : #'api - accessing' }
GtSpotterDropdownButtonStencil >> tooltip: aString [
	tooltip := aString
]
