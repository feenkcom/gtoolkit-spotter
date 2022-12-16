Class {
	#name : #GtSpotterObjectActOn,
	#superclass : #GtSpotterActOn,
	#instVars : [
		'rawObject'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #deprecated }
GtSpotterObjectActOn >> element [
	self
		deprecated: 'Use #rawObject instead'
		transformWith: '`@receiver element' -> '`@receiver rawObject'.

	^ self rawObject
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

{ #category : #'api - accessing' }
GtSpotterObjectActOn >> toolToSend [
	<return: #GtPhlowTool>

	^ search
		objectToolToActOn: self objectToSend
		rawObject: self rawObject
		from: step
]
