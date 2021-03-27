Class {
	#name : #GtSpotterSearchField,
	#superclass : #BrEditor,
	#instVars : [
		'spotterModel'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #initialization }
GtSpotterSearchField >> initialize [
	super initialize.

	self aptitude: (BrGlamorousRegularEditorAptitude new fontSize: 18).
	self requestFocus
]

{ #category : #'private - event handling' }
GtSpotterSearchField >> onCurrentStepChanged: anAnnouncement [
	self text: anAnnouncement stepModel searchQuery asRopedText.
	self navigator
		moveTo: self text size;
		apply.

	self requestFocus
]

{ #category : #'private - accessing' }
GtSpotterSearchField >> spotterModel [
	<return: #GtSpotter>

	^ spotterModel
]

{ #category : #'api - accessing' }
GtSpotterSearchField >> spotterModel: aGtSpotter [
	spotterModel := aGtSpotter.
	
	aGtSpotter text ifNotEmpty: [ 
		self editor text: aGtSpotter text asRopedText.
		self editor selecter all; select.
	].

	self editor
		when: BrTextEditorModifiedEvent
		do: [ :anEvent | self spotterModel search: anEvent currentTarget text asString ].

	spotterModel announcer 
		when: GtSpotterCurrentStepChanged
		send: #onCurrentStepChanged:
		to: self
]
