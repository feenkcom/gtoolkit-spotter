Class {
	#name : #GtSpotterStepItemElement,
	#superclass : #BrHorizontalPane,
	#instVars : [
		'stepModel',
		'isMouseHovering'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #initialization }
GtSpotterStepItemElement >> initialize [
	super initialize.
	self unmarkMouseIsHovering.
	self initializeActionsVisibility.
]

{ #category : #initialization }
GtSpotterStepItemElement >> initializeActionsVisibility [
	self
		when: BlMouseEnterEvent
		do: [ :anEvent | self onMouseEnter ].
	self
		when: BlMouseLeaveEvent
		do: [ :anEvent | self onMouseLeave ].
]

{ #category : #'private - testing' }
GtSpotterStepItemElement >> isMouseHovering [
	<return: #Boolean>
	^ isMouseHovering
]

{ #category : #'private - actions' }
GtSpotterStepItemElement >> markMouseIsHovering [
	isMouseHovering := true
]

{ #category : #'private - hooks' }
GtSpotterStepItemElement >> onCandidateSelected: aGtSpotterSelectedCandidateChanged [
]

{ #category : #'private - hooks' }
GtSpotterStepItemElement >> onMouseEnter [
	self markMouseIsHovering.
]

{ #category : #'private - hooks' }
GtSpotterStepItemElement >> onMouseLeave [
	self unmarkMouseIsHovering.
]

{ #category : #'private - accessing' }
GtSpotterStepItemElement >> stepModel [
	^ stepModel
]

{ #category : #'api - accessing' }
GtSpotterStepItemElement >> stepModel: aGtSpotterStep [
	self unsubscribeFromSpotterStep.
	stepModel := aGtSpotterStep.
	self subscribeToSpotterStep.
]

{ #category : #'private - accessing' }
GtSpotterStepItemElement >> stepModelDo: aBlock [
	self stepModel ifNotNil: aBlock
]

{ #category : #'private - subscriptions' }
GtSpotterStepItemElement >> subscribeToSpotterStep [
	self stepModel announcer
		when: GtSpotterSelectedCandidateChanged
		send: #onCandidateSelected:
		to: self.
]

{ #category : #'private - actions' }
GtSpotterStepItemElement >> unmarkMouseIsHovering [
	isMouseHovering := false
]

{ #category : #'private - subscriptions' }
GtSpotterStepItemElement >> unsubscribeFromSpotterStep [
	self stepModelDo: [ :aModel | aModel announcer unsubscribe: self ].
]
