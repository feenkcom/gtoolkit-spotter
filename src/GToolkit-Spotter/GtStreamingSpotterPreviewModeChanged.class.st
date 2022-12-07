Class {
	#name : #GtStreamingSpotterPreviewModeChanged,
	#superclass : #GtStreamingSpotterAnnouncement,
	#instVars : [
		'shouldShowPreview'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtStreamingSpotterPreviewModeChanged >> shouldShowPreview [

	^ shouldShowPreview
]

{ #category : #accessing }
GtStreamingSpotterPreviewModeChanged >> shouldShowPreview: anObject [

	shouldShowPreview := anObject
]
