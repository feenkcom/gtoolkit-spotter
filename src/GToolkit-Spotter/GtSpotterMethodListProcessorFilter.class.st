Class {
	#name : #GtSpotterMethodListProcessorFilter,
	#superclass : #GtSpotterProcessorFilter,
	#instVars : [
		'selectedMethodSignatures',
		'configurationBlocks'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #adding }
GtSpotterMethodListProcessorFilter >> allowProcessorsFrom: aMethod [
	|signature|
	
	signature := self signatureFor: aMethod.
	(selectedMethodSignatures includes: signature) ifFalse: [ selectedMethodSignatures add: signature ].
	
]

{ #category : #adding }
GtSpotterMethodListProcessorFilter >> allowProcessorsFrom: aMethod configuredWith: aBlock [
	
	self allowProcessorsFrom: aMethod.
	configurationBlocks at: aMethod printString put: aBlock.
	
]

{ #category : #accessing }
GtSpotterMethodListProcessorFilter >> configurationBlockForProcessorsCreatedBy: aMethod [
	
	^ configurationBlocks at: aMethod printString ifAbsent: [ self nullConfigurationBlock ]
]

{ #category : #initialization }
GtSpotterMethodListProcessorFilter >> initialize [
	super initialize.

	selectedMethodSignatures := OrderedCollection new.
	configurationBlocks := Dictionary new.
]

{ #category : #accessing }
GtSpotterMethodListProcessorFilter >> nullConfigurationBlock [

	^ [ :processor | ]
]

{ #category : #printing }
GtSpotterMethodListProcessorFilter >> printSignature: aSignature [

	^ aSignature first name, '>>', aSignature second asString
]

{ #category : #testing }
GtSpotterMethodListProcessorFilter >> shouldEnableProcessorsCreateBy: aMethod [

	^ selectedMethodSignatures anySatisfy: [ :aSignature | 
		aSignature first = aMethod methodClass and: [ aSignature second = aMethod selector ] ]
]

{ #category : #accessing }
GtSpotterMethodListProcessorFilter >> signatureFor: aMethod [

	^ {aMethod methodClass . aMethod selector}
]
