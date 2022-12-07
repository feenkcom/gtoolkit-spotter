Class {
	#name : #GtSpotterStepPopped,
	#superclass : #GtSpotterAnnouncement,
	#instVars : [
		'spotterStep',
		'stepIndex'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterStepPopped >> spotterStep [

	^ spotterStep
]

{ #category : #accessing }
GtSpotterStepPopped >> spotterStep: anObject [

	spotterStep := anObject
]

{ #category : #accessing }
GtSpotterStepPopped >> stepIndex [

	^ stepIndex
]

{ #category : #accessing }
GtSpotterStepPopped >> stepIndex: anObject [

	stepIndex := anObject
]
