Class {
	#name : #GtSpotterCategorySelected,
	#superclass : #GTSpotterAnnouncement,
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #'as yet unclassified' }
GtSpotterCategorySelected >> asRecorderEvent [

	^ GTSpotterRecorderCategorySelectedEvent fromAnnouncement: self
]
