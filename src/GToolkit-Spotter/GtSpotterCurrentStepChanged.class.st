Class {
	#name : #GtSpotterCurrentStepChanged,
	#superclass : #Announcement,
	#instVars : [
		'stepModel',
		'index'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterCurrentStepChanged >> index [
	^ index
]

{ #category : #accessing }
GtSpotterCurrentStepChanged >> index: aNumber [

	self
		assert: [ aNumber > 0 ]
		description: [ 'Step index must be positive' ].

	index := aNumber
]

{ #category : #accessing }
GtSpotterCurrentStepChanged >> stepModel [
	<return: #GtSpotterStep>

	^ stepModel
]

{ #category : #accessing }
GtSpotterCurrentStepChanged >> stepModel: aStepModel [
	stepModel := aStepModel
]
