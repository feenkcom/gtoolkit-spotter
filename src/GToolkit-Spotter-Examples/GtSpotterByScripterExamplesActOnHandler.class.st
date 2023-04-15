Class {
	#name : #GtSpotterByScripterExamplesActOnHandler,
	#superclass : #Object,
	#instVars : [
		'actOnEvents'
	],
	#category : #'GToolkit-Spotter-Examples-Support'
}

{ #category : #accessing }
GtSpotterByScripterExamplesActOnHandler >> actOnEvents [
	^ actOnEvents
]

{ #category : #accessing }
GtSpotterByScripterExamplesActOnHandler >> actOnEvents: anObject [
	actOnEvents := anObject
]

{ #category : #'event handling' }
GtSpotterByScripterExamplesActOnHandler >> onActed: anAnnouncement [
	anAnnouncement beActed.
	actOnEvents add: anAnnouncement
]
