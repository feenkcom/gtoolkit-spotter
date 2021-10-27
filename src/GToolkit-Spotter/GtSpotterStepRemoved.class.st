Class {
	#name : #GtSpotterStepRemoved,
	#superclass : #Announcement,
	#instVars : [
		'stepModel',
		'index'
	],
	#category : 'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterStepRemoved >> index [
	^ index
]

{ #category : #accessing }
GtSpotterStepRemoved >> index: anObject [
	index := anObject
]

{ #category : #accessing }
GtSpotterStepRemoved >> stepModel [
	^ stepModel
]

{ #category : #accessing }
GtSpotterStepRemoved >> stepModel: anObject [
	stepModel := anObject
]
