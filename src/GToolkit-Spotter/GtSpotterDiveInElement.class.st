Class {
	#name : #GtSpotterDiveInElement,
	#superclass : #Announcement,
	#instVars : [
		'element',
		'eventType'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #'as yet unclassified' }
GtSpotterDiveInElement >> asRecorderEvent [
	^ GTSpotterRecorderDiveInElementEvent fromAnnouncement: self
]

{ #category : #accessing }
GtSpotterDiveInElement >> element [
	^ element
]

{ #category : #accessing }
GtSpotterDiveInElement >> element: anObject [
	element := anObject
]

{ #category : #accessing }
GtSpotterDiveInElement >> eventType [
	^ eventType
]

{ #category : #accessing }
GtSpotterDiveInElement >> eventType: anObject [
	eventType := anObject
]
