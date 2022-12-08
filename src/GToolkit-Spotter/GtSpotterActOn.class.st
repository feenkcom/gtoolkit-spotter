Class {
	#name : #GtSpotterActOn,
	#superclass : #GtSpotterAnnouncement,
	#instVars : [
		'eventType',
		'isActedUpon',
		'search',
		'step'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterActOn >> actedUpon: aBoolean [
	isActedUpon := aBoolean
]

{ #category : #accessing }
GtSpotterActOn >> beActed [
	self actedUpon: true.
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

{ #category : #'api - accessing' }
GtSpotterActOn >> objectToSend [
	<return: #Object>
	
	^ self subclassResponsibility
]

{ #category : #'private - notifying' }
GtSpotterActOn >> search: aSpotterSearch [ 
	search := aSpotterSearch
]

{ #category : #'api - accessing' }
GtSpotterActOn >> spotterSearch [
	^ search
]

{ #category : #'api - accessing' }
GtSpotterActOn >> spotterStep [
	^ step
]

{ #category : #'private - notifying' }
GtSpotterActOn >> step: aSpotterStep [ 
	step := aSpotterStep
]

{ #category : #'api - accessing' }
GtSpotterActOn >> toolToSend [
	<return: #GtPhlowTool>
	
	^ self subclassResponsibility
]
