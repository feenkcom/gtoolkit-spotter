Class {
	#name : #GtSpotterDropdownButtonActOnHandler,
	#superclass : #Object,
	#instVars : [
		'spotterModel',
		'spotterElement',
		'button',
		'objectActOn',
		'categoryActOn'
	],
	#category : #'GToolkit-Spotter-UI-Stencils'
}

{ #category : #asserting }
GtSpotterDropdownButtonActOnHandler >> assertInitialization [
	self
		assert: [ self spotterModel isNotNil ]
		description: [ 'Spotter model must be non-nil' ].
	self
		assert: [ self spotterElement isNotNil ]
		description: [ 'Spotter element must be non-nil' ].
	self
		assert: [ self button isNotNil ]
		description: [ 'Spotter button (anchor button) must be non-nil' ].
	self
		assert: [ self objectActOn isNotNil ]
		description: [ 'Spotter objectActOn must be non-nil' ].
	self
		assert: [ self categoryActOn isNotNil ]
		description: [ 'Spotter categoryActOn must be non-nil' ]
]

{ #category : #accessing }
GtSpotterDropdownButtonActOnHandler >> button [
	^ button
]

{ #category : #accessing }
GtSpotterDropdownButtonActOnHandler >> button: anObject [
	button := anObject
]

{ #category : #accessing }
GtSpotterDropdownButtonActOnHandler >> categoryActOn [
	^ categoryActOn
]

{ #category : #accessing }
GtSpotterDropdownButtonActOnHandler >> categoryActOn: anObject [
	categoryActOn := anObject
]

{ #category : #'event handling' }
GtSpotterDropdownButtonActOnHandler >> hideDropdown [
	"hide Spotter in the next Space iteration 
	to be able to open a new World tab if necessary"

	BlTaskAction
		enqueueElement: self button
		action: [
			self button isAttachedToSceneGraph
				ifTrue: [ self button fireEvent: (BrDropdownHideWish new anchor: self button) ]
				ifFalse: [  
					"Since the anchor button is removed from the space,
					we enqueue the hide-wish task to wait for the moment
					the anchor button is displayed again.
					
					See https://github.com/feenkcom/gtoolkit/issues/4375
					The question is whether we should support something like forced-hide-event
					that would remove the temporary hidden dropdown and cleaned its caches."
					BlTaskAction
						enqueueElement: self button
						action: [ self button fireEvent: (BrDropdownHideWish new anchor: self button) ] ] ]
]

{ #category : #initialization }
GtSpotterDropdownButtonActOnHandler >> install [
	self assertInitialization.

	self spotterElement userData 
		at: GtSpotterDropdownButtonActOnHandler 
		put: self.

	self spotterModel announcer weak
		when: GtSpotterObjectActOn
		send: #onObjectActOn:
		to: self.
		
	self spotterModel announcer weak
		when: GtSpotterCategoryActOn
		send: #onCategoryActOn:
		to: self
]

{ #category : #accessing }
GtSpotterDropdownButtonActOnHandler >> objectActOn [
	^ objectActOn
]

{ #category : #accessing }
GtSpotterDropdownButtonActOnHandler >> objectActOn: anObject [
	objectActOn := anObject
]

{ #category : #'event handling' }
GtSpotterDropdownButtonActOnHandler >> onCategoryActOn: anAnnouncement [
	self unsubscribeMySelf.
	
	categoryActOn
		cull: anAnnouncement
		cull: anAnnouncement rawCategory
		cull: self button.
		
	self hideDropdown
]

{ #category : #'event handling' }
GtSpotterDropdownButtonActOnHandler >> onObjectActOn: anAnnouncement [
	self unsubscribeMySelf.
	
	objectActOn
		cull: anAnnouncement
		cull: anAnnouncement rawObject
		cull: self button.
		
	self hideDropdown
]

{ #category : #accessing }
GtSpotterDropdownButtonActOnHandler >> spotterElement [
	^ spotterElement
]

{ #category : #accessing }
GtSpotterDropdownButtonActOnHandler >> spotterElement: anObject [
	spotterElement := anObject
]

{ #category : #accessing }
GtSpotterDropdownButtonActOnHandler >> spotterModel [
	^ spotterModel
]

{ #category : #accessing }
GtSpotterDropdownButtonActOnHandler >> spotterModel: anObject [
	spotterModel := anObject
]

{ #category : #'event handling' }
GtSpotterDropdownButtonActOnHandler >> unsubscribeMySelf [
	self spotterModel unsubscribe: self
]
