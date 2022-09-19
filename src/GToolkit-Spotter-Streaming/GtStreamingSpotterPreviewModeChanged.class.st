Class {
	#name : #GtStreamingSpotterPreviewModeChanged,
	#superclass : #GtStreamingSpotterAnnouncement,
	#instVars : [
		'shouldShowPreview'
	],
	#category : #'GToolkit-Spotter-Streaming-Events'
}

{ #category : #accessing }
GtStreamingSpotterPreviewModeChanged >> shouldShowPreview [

	^ shouldShowPreview
]

{ #category : #accessing }
GtStreamingSpotterPreviewModeChanged >> shouldShowPreview: anObject [

	shouldShowPreview := anObject
]
