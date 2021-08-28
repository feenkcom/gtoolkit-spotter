Class {
	#name : 'GlamorousAuthor',
	#superclass : 'Announcement',
	#instVars : [
		'category'
	],
	#category : 'GToolkit-Spotter-Announcements'
}

{ #category : 'accessing' }
GlamorousAuthor >> category [
	"Return the category (ie the kind of group of elements). This has nothing to do with class category."
	^ category
]

{ #category : 'accessing' }
GlamorousAuthor >> category: anObject [
	"Set the category (ie the kind of group of elements). This has nothing to do with class category."
	category := anObject
]
