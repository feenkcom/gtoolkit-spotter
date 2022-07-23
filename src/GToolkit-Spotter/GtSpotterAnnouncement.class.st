Class {
	#name : #GtSpotterAnnouncement,
	#superclass : #Announcement,
	#instVars : [
		'category'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterAnnouncement >> category [
	"Return the category (ie the kind of group of elements). This has nothing to do with class category."
	^ category
]

{ #category : #accessing }
GtSpotterAnnouncement >> category: anObject [
	"Set the category (ie the kind of group of elements). This has nothing to do with class category."
	category := anObject
]
