Class {
	#name : #GtSpotterActOn,
	#superclass : #Announcement,
	#instVars : [
		'element',
		'eventType'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #'as yet unclassified' }
GtSpotterActOn >> asRecorderEvent [

	^ GTSpotterRecorderActOnEvent fromAnnouncement: self
]

{ #category : #accessing }
GtSpotterActOn >> element [
	^ element
]

{ #category : #accessing }
GtSpotterActOn >> element: anObject [
	element := anObject
]

{ #category : #accessing }
GtSpotterActOn >> eventType [
	^ eventType
]

{ #category : #accessing }
GtSpotterActOn >> eventType: anObject [
	eventType := anObject
]
