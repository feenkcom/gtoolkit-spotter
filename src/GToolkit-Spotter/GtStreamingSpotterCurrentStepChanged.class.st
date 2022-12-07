Class {
	#name : #GtStreamingSpotterCurrentStepChanged,
	#superclass : #GtStreamingSpotterAnnouncement,
	#instVars : [
		'spotterStep',
		'stepIndex'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtStreamingSpotterCurrentStepChanged >> spotterStep [

	^ spotterStep
]

{ #category : #accessing }
GtStreamingSpotterCurrentStepChanged >> spotterStep: anObject [

	spotterStep := anObject
]

{ #category : #accessing }
GtStreamingSpotterCurrentStepChanged >> stepIndex [

	^ stepIndex
]

{ #category : #accessing }
GtStreamingSpotterCurrentStepChanged >> stepIndex: anObject [

	stepIndex := anObject
]
