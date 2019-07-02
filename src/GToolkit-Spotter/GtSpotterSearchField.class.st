Class {
	#name : #GtSpotterSearchField,
	#superclass : #BrEditor,
	#instVars : [
		'spotterModel'
	],
	#category : #'GToolkit-Spotter-UI-Bloc'
}

{ #category : #initialization }
GtSpotterSearchField >> initialize [
	super initialize.
	
	self look: BrGlamorousRegularEditorLook new + (BrInteractiveCommonLook new
		default: [
			self padding: (BlInsets all: 10).
			self border: (BlBorder paint: BrGlamorousColors editorBorderColor width: 1) ];
		focused: [ self border: (BlBorder paint: BrGlamorousColors focusedEditorBorderColor width: 1) ]).
]

{ #category : #accessing }
GtSpotterSearchField >> spotterModel [
	^ spotterModel
]

{ #category : #accessing }
GtSpotterSearchField >> spotterModel: aGtSpotter [
	spotterModel := aGtSpotter.

	self editor when: BrTextEditorInsertedEvent do: [ :anEvent | self spotterModel setText: anEvent currentTarget text asString ].
	self editor when: BrTextEditorDeletedEvent do: [ :anEvent | self spotterModel setText: anEvent currentTarget text asString ]
]
