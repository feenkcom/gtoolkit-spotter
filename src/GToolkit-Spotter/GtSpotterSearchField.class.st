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

	self look: (BrGlamorousRegularEditorLook new fontSize: 18)
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
