Class {
	#name : #GtSpotterTask,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #async }
GtSpotterTask >> execute: aBlock withArguments: aCollection callback: callbackBlock priority: aPriority delay: anIntegerMilliseconds [
	self subclassResponsibility
]
