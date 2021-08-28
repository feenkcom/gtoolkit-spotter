Class {
	#name : 'GtSpotterAmountElement',
	#superclass : 'BrLabel',
	#instVars : [
		'visible',
		'total'
	],
	#category : 'GToolkit-Spotter-UI'
}

{ #category : 'api - accessing' }
GtSpotterAmountElement >> assertInteger: anInteger [
	self 
		assert: [ anInteger isNotNil ] 
		description: [ 'Amount must be non-nil' ].
	self 
		assert: [ anInteger isInteger ] 
		description: [ 'Amount must be an integer' ].
	self 
		assert: [ anInteger >= 0 ] 
		description: [ 'Amount must be zero or positive number' ].
]

{ #category : 'initialization' }
GtSpotterAmountElement >> initialize [
	super initialize.
	visible := 0.
	total := 0.
	self updateVisible: 0 total: 0.
	self visibility: BlVisibility hidden.
]

{ #category : 'private - accessing' }
GtSpotterAmountElement >> total [
	<return: #Integer>
	^ total
]

{ #category : 'api - accessing' }
GtSpotterAmountElement >> total: anInteger [
	self assertInteger: anInteger.
	total := anInteger.
	self updateText.
]

{ #category : 'private - updating' }
GtSpotterAmountElement >> updateText [
	"I must be called in a UI processs"
	self updateVisible: self visible total: self total.
]

{ #category : 'private - updating' }
GtSpotterAmountElement >> updateVisible: aVisible total: aTotal [
	| aTotalString |
	aTotalString := aTotal < aVisible
		ifTrue: [ '...' ] ifFalse: [ self total asString ].
	self text: aVisible asString, '/', aTotalString asString.
	self visibility: BlVisibility visible.
]

{ #category : 'private - accessing' }
GtSpotterAmountElement >> visible [
	<return: #Integer>
	^ visible
]

{ #category : 'api - accessing' }
GtSpotterAmountElement >> visible: anInteger [
	self assertInteger: anInteger.
	visible := anInteger.
	self updateText.
]
