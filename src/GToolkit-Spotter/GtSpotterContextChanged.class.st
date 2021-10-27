Class {
	#name : #GtSpotterContextChanged,
	#superclass : #Announcement,
	#instVars : [
		'previous',
		'current'
	],
	#category : 'GToolkit-Spotter-Announcements'
}

{ #category : #compatibility }
GtSpotterContextChanged >> context [
	^ self current
]

{ #category : #compatibility }
GtSpotterContextChanged >> context: aSpotterContext [
	self current: aSpotterContext
]

{ #category : #accessing }
GtSpotterContextChanged >> current [
	^ current
]

{ #category : #accessing }
GtSpotterContextChanged >> current: anObject [
	current := anObject
]

{ #category : #'accessing-dynamic' }
GtSpotterContextChanged >> currentText [
	^ self current ifNil: [''] ifNotNil: [ self current text ]
]

{ #category : #accessing }
GtSpotterContextChanged >> previous [
	^ previous
]

{ #category : #accessing }
GtSpotterContextChanged >> previous: anObject [
	previous := anObject
]

{ #category : #'accessing-dynamic' }
GtSpotterContextChanged >> previousText [
	^ self previous ifNil: ['']  ifNotNil: [ self previous text ]
]

{ #category : #compatibility }
GtSpotterContextChanged >> text [
	^ self currentText
]
