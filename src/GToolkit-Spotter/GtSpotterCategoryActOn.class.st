Class {
	#name : #GtSpotterCategoryActOn,
	#superclass : #Announcement,
	#instVars : [
		'eventType',
		'isActedUpon',
		'search',
		'step',
		'rawCategory'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterCategoryActOn >> actedUpon: aBoolean [
	isActedUpon := aBoolean
]

{ #category : #accessing }
GtSpotterCategoryActOn >> beActed [
	self actedUpon: true.
]

{ #category : #accessing }
GtSpotterCategoryActOn >> eventType [
	^ eventType
]

{ #category : #accessing }
GtSpotterCategoryActOn >> eventType: anObject [
	eventType := anObject
]

{ #category : #initialization }
GtSpotterCategoryActOn >> initialize [
	super initialize.
	
	isActedUpon := false
]

{ #category : #accessing }
GtSpotterCategoryActOn >> isActedUpon [
	^ isActedUpon
]

{ #category : #accessing }
GtSpotterCategoryActOn >> objectToSend [
	^ search
		objectToActOn: rawCategory
		from: step
]

{ #category : #accessing }
GtSpotterCategoryActOn >> rawCategory [
	^ rawCategory
]

{ #category : #'private - notifying' }
GtSpotterCategoryActOn >> search: aSpotterSearch [ 
	search := aSpotterSearch
]

{ #category : #'private - notifying' }
GtSpotterCategoryActOn >> step: aSpotterStep [ 
	step := aSpotterStep
]
