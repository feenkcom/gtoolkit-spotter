Class {
	#name : #GtSpotterStream,
	#superclass : #Object,
	#instVars : [
		'timestamp',
		'onAddedSelector',
		'onAddedAllSelector',
		'onRemoveSelector',
		'receiver'
	],
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #'adding/removing' }
GtSpotterStream >> addObject: firstObject inProcessor: secondObject [
	| aCandidate |
	
	aCandidate := GtSpotterCandidate new
		item: firstObject;
		processor: secondObject.

	self performSymbol: self onAddedSelector withArguments: { aCandidate }
]

{ #category : #'adding/removing' }
GtSpotterStream >> addObjects: aCollection inProcessor: aProcessor [
	| theCandidates |
	
	theCandidates := aCollection collect: [ :eachItem |
		GtSpotterCandidate new
			item: eachItem;
			processor: aProcessor ].

	self performSymbol: self onAddedAllSelector withArguments: { theCandidates }.
]

{ #category : #accessing }
GtSpotterStream >> attachedTo: anElement [
	self subclassResponsibility
]

{ #category : #accessing }
GtSpotterStream >> onAddedAllSelector [
	^ onAddedAllSelector
]

{ #category : #accessing }
GtSpotterStream >> onAddedAllSelector: anObject [
	onAddedAllSelector := anObject
]

{ #category : #accessing }
GtSpotterStream >> onAddedSelector [
	^ onAddedSelector
]

{ #category : #accessing }
GtSpotterStream >> onAddedSelector: anObject [
	onAddedSelector := anObject
]

{ #category : #accessing }
GtSpotterStream >> onRemoveSelector [
	^ onRemoveSelector
]

{ #category : #accessing }
GtSpotterStream >> onRemoveSelector: anObject [
	onRemoveSelector := anObject
]

{ #category : #performing }
GtSpotterStream >> performCallback: aBlock [
	
	self performSymbol: #value withArguments: #() receiver: aBlock
]

{ #category : #performing }
GtSpotterStream >> performSymbol: aSymbol withArguments: aCollection [
	
	self performSymbol: aSymbol withArguments: aCollection receiver: self receiver
]

{ #category : #performing }
GtSpotterStream >> performSymbol: aSymbol withArguments: aCollection receiver: aReceiver [
	self subclassResponsibility
]

{ #category : #accessing }
GtSpotterStream >> receiver [
	^ receiver
]

{ #category : #accessing }
GtSpotterStream >> receiver: anObject [
	receiver := anObject
]

{ #category : #'adding/removing' }
GtSpotterStream >> removeAllCandidates [

	self performSymbol: #removeAllCandidates withArguments: { }.
]

{ #category : #accessing }
GtSpotterStream >> timestamp [
	^ timestamp
]

{ #category : #accessing }
GtSpotterStream >> timestamp: anObject [
	timestamp := anObject
]

{ #category : #updating }
GtSpotterStream >> updateTimestamp [

	self timestamp: Time microsecondClockValue
]
