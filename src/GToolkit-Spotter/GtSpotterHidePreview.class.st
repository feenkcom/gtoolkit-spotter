Class {
	#name : #GtSpotterHidePreview,
	#superclass : #Announcement,
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #'as yet unclassified' }
GtSpotterHidePreview >> asRecorderEvent [

	^ GTSpotterRecorderHidePreviewEvent fromAnnouncement: self
]
