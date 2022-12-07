Class {
	#name : #GtSpotterPreviewModeChanged,
	#superclass : #GtSpotterAnnouncement,
	#instVars : [
		'shouldShowPreview'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterPreviewModeChanged >> shouldShowPreview [

	^ shouldShowPreview
]

{ #category : #accessing }
GtSpotterPreviewModeChanged >> shouldShowPreview: anObject [

	shouldShowPreview := anObject
]
