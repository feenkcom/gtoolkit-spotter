Class {
	#name : 'GtSpotterStepAdded',
	#superclass : 'Announcement',
	#instVars : [
		'stepModel',
		'index'
	],
	#category : 'GToolkit-Spotter-Announcements'
}

{ #category : 'accessing' }
GtSpotterStepAdded >> index [
	^ index
]

{ #category : 'accessing' }
GtSpotterStepAdded >> index: anObject [
	index := anObject
]

{ #category : 'accessing' }
GtSpotterStepAdded >> stepModel [
	^ stepModel
]

{ #category : 'accessing' }
GtSpotterStepAdded >> stepModel: anObject [
	stepModel := anObject
]
