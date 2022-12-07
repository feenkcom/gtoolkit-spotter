Class {
	#name : #GtSpotterObjectActOn,
	#superclass : #GtSpotterAnnouncement,
	#instVars : [
		'eventType',
		'isActedUpon',
		'search',
		'step',
		'rawObject'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #'api - actions' }
GtSpotterObjectActOn >> actedUpon: aBoolean [
	isActedUpon := aBoolean
]

{ #category : #'api - actions' }
GtSpotterObjectActOn >> beActed [
	self actedUpon: true.
]

{ #category : #deprecated }
GtSpotterObjectActOn >> element [
	self
		deprecated: 'Use #rawObject instead'
		transformWith: '`@receiver element' -> '`@receiver rawObject'.

	^ self rawObject
]

{ #category : #'api - accessing' }
GtSpotterObjectActOn >> eventType [
	^ eventType
]

{ #category : #initialization }
GtSpotterObjectActOn >> eventType: anObject [
	eventType := anObject
]

{ #category : #initialization }
GtSpotterObjectActOn >> initialize [
	super initialize.
	
	isActedUpon := false
]

{ #category : #'api - testing' }
GtSpotterObjectActOn >> isActedUpon [
	^ isActedUpon
]

{ #category : #deprecated }
GtSpotterObjectActOn >> object [
	self
		deprecated: 'Use #rawObject instead'
		transformWith: '`@receiver object' -> '`@receiver rawObject'.

	^ self rawObject
]

{ #category : #'api - accessing' }
GtSpotterObjectActOn >> objectToSend [
	<return: #Object>

	^ search
		objectToActOn: rawObject
		from: step
]

{ #category : #'api - accessing' }
GtSpotterObjectActOn >> rawObject [
	<return: #Object>

	^ rawObject
]

{ #category : #initialization }
GtSpotterObjectActOn >> rawObject: anObject [
	rawObject := anObject
]

{ #category : #deprecated }
GtSpotterObjectActOn >> realItem [
	self
		deprecated: 'Use #object instead'
		transformWith: '`@receiver realItem' -> '`@receiver rawObject'.

	^ self rawObject
]

{ #category : #initialization }
GtSpotterObjectActOn >> search: aSpotterSearch [ 
	search := aSpotterSearch
]

{ #category : #'api - accessing' }
GtSpotterObjectActOn >> spotterSearch [
	^ search
]

{ #category : #'api - accessing' }
GtSpotterObjectActOn >> spotterStep [
	^ step
]

{ #category : #initialization }
GtSpotterObjectActOn >> step: aSpotterStep [ 
	step := aSpotterStep
]

{ #category : #'api - accessing' }
GtSpotterObjectActOn >> toolToSend [
	<return: #GtPhlowTool>

	^ search
		objectToolToActOn: rawObject
		from: step
]
