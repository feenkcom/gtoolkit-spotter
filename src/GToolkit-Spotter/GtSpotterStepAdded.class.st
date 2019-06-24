Class {
	#name : #GtSpotterStepAdded,
	#superclass : #Announcement,
	#instVars : [
		'stepModel'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #accessing }
GtSpotterStepAdded >> stepModel [
	^ stepModel
]

{ #category : #accessing }
GtSpotterStepAdded >> stepModel: anObject [
	stepModel := anObject
]
