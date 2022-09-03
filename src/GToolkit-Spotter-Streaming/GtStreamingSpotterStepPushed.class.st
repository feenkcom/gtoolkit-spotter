Class {
	#name : #GtStreamingSpotterStepPushed,
	#superclass : #GtStreamingSpotterAnnouncement,
	#instVars : [
		'spotterStep'
	],
	#category : #'GToolkit-Spotter-Streaming-Events'
}

{ #category : #accessing }
GtStreamingSpotterStepPushed >> spotterStep [

	^ spotterStep
]

{ #category : #accessing }
GtStreamingSpotterStepPushed >> spotterStep: anObject [

	spotterStep := anObject
]
