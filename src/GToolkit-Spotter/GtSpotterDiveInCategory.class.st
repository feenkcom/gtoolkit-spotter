Class {
	#name : #GtSpotterDiveInCategory,
	#superclass : #GTSpotterAnnouncement,
	#instVars : [
		'eventType'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #'as yet unclassified' }
GtSpotterDiveInCategory >> asRecorderEvent [

	^ GTSpotterRecorderDiveInCategoryEvent fromAnnouncement: self
]

{ #category : #accessing }
GtSpotterDiveInCategory >> eventType [
	^ eventType
]

{ #category : #accessing }
GtSpotterDiveInCategory >> eventType: anObject [
	eventType := anObject
]
