Class {
	#name : #GtSpotterActOn,
	#superclass : #Announcement,
	#instVars : [
		'element',
		'eventType',
		'isActedUpon'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterActOn >> actedUpon: aBoolean [
	isActedUpon := aBoolean
]

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

{ #category : #initialization }
GtSpotterActOn >> initialize [
	super initialize.
	
	isActedUpon := false
]

{ #category : #accessing }
GtSpotterActOn >> isActedUpon [
	^ isActedUpon
]
