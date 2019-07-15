Class {
	#name : #GtSpotterCategorySelected,
	#superclass : #GlamorousAuthor,
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #'as yet unclassified' }
GtSpotterCategorySelected >> asRecorderEvent [

	^ GTSpotterRecorderCategorySelectedEvent fromAnnouncement: self
]
