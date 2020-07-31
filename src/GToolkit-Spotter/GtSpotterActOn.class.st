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

{ #category : #accessing }
GtSpotterActOn >> beActed [
	self actedUpon: true.
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

{ #category : #accessing }
GtSpotterActOn >> realItem [
	| anItem |
	anItem := self element.
	self flag: 'FIXME candidates may be wrapped for some reason'.
	[ (anItem isKindOf: self class) and: [ anItem item ~~ anItem ] ]
		whileTrue: [ anItem := anItem item ].
	^ anItem
]
