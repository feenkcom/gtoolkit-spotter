Class {
	#name : #GtSpotterUIThreadStream,
	#superclass : #Object,
	#instVars : [
		'onAddedSelector',
		'onAddedAllSelector',
		'onRemoveSelector',
		'receiver',
		'timestamp'
	],
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #'adding/removing' }
GtSpotterUIThreadStream >> addObject: firstObject inProcessor: secondObject [
	| aCandidate |
	
	aCandidate := GtSpotterCandidate new
		item: firstObject;
		processor: secondObject.

	self performSymbol: self onAddedSelector withArguments: { aCandidate }
]

{ #category : #'adding/removing' }
GtSpotterUIThreadStream >> addObjects: aCollection inProcessor: aProcessor [	
	| theCandidates |
	
	theCandidates := aCollection collect: [ :eachItem |
		GtSpotterCandidate new
			item: eachItem;
			processor: aProcessor ].

	self performSymbol: self onAddedAllSelector withArguments: { theCandidates }.
]

{ #category : #accessing }
GtSpotterUIThreadStream >> onAddedAllSelector [
	^ onAddedAllSelector
]

{ #category : #accessing }
GtSpotterUIThreadStream >> onAddedAllSelector: anObject [
	onAddedAllSelector := anObject
]

{ #category : #accessing }
GtSpotterUIThreadStream >> onAddedSelector [
	^ onAddedSelector
]

{ #category : #accessing }
GtSpotterUIThreadStream >> onAddedSelector: anObject [
	onAddedSelector := anObject
]

{ #category : #accessing }
GtSpotterUIThreadStream >> onRemoveSelector [
	^ onRemoveSelector
]

{ #category : #accessing }
GtSpotterUIThreadStream >> onRemoveSelector: anObject [
	onRemoveSelector := anObject
]

{ #category : #performing }
GtSpotterUIThreadStream >> performSymbol: aSymbol withArguments: aCollection [
	| time |

	"we save current timestamp here, so that defer block can check if it belongs to the correct task"
	time := self timestamp.
	"UI manages commands for us"
	Processor yield.
	"if timestamp is wrong just skip command"
	BlUniverse defer: [ time = self timestamp ifTrue: [ self receiver perform: aSymbol withEnoughArguments: aCollection ] ]
]

{ #category : #accessing }
GtSpotterUIThreadStream >> receiver [
	^ receiver
]

{ #category : #accessing }
GtSpotterUIThreadStream >> receiver: anObject [
	receiver := anObject
]

{ #category : #'adding/removing' }
GtSpotterUIThreadStream >> removeAllCandidates [

	self performSymbol: #removeAllCandidates withArguments: { }.
]

{ #category : #accessing }
GtSpotterUIThreadStream >> timestamp [
	^ timestamp
]

{ #category : #accessing }
GtSpotterUIThreadStream >> timestamp: anObject [
	timestamp := anObject
]

{ #category : #updating }
GtSpotterUIThreadStream >> updateTimestamp [

	self timestamp: Time microsecondClockValue
]
