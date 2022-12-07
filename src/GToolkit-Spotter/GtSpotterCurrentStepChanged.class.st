Class {
	#name : #GtSpotterCurrentStepChanged,
	#superclass : #GtSpotterAnnouncement,
	#instVars : [
		'spotterStep',
		'stepIndex'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterCurrentStepChanged >> spotterStep [

	^ spotterStep
]

{ #category : #accessing }
GtSpotterCurrentStepChanged >> spotterStep: anObject [

	spotterStep := anObject
]

{ #category : #accessing }
GtSpotterCurrentStepChanged >> stepIndex [

	^ stepIndex
]

{ #category : #accessing }
GtSpotterCurrentStepChanged >> stepIndex: anObject [

	stepIndex := anObject
]
