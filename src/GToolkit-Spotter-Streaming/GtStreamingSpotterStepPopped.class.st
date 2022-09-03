Class {
	#name : #GtStreamingSpotterStepPopped,
	#superclass : #GtStreamingSpotterAnnouncement,
	#instVars : [
		'spotterStep',
		'stepIndex'
	],
	#category : #'GToolkit-Spotter-Streaming-Events'
}

{ #category : #accessing }
GtStreamingSpotterStepPopped >> spotterStep [

	^ spotterStep
]

{ #category : #accessing }
GtStreamingSpotterStepPopped >> spotterStep: anObject [

	spotterStep := anObject
]

{ #category : #accessing }
GtStreamingSpotterStepPopped >> stepIndex [

	^ stepIndex
]

{ #category : #accessing }
GtStreamingSpotterStepPopped >> stepIndex: anObject [

	stepIndex := anObject
]
