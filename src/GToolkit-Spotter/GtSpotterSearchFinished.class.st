Class {
	#name : 'GtSpotterSearchFinished',
	#superclass : 'Announcement',
	#instVars : [
		'processors',
		'query'
	],
	#category : 'GToolkit-Spotter-Announcements'
}

{ #category : 'accessing' }
GtSpotterSearchFinished >> processors [
	^ processors
]

{ #category : 'accessing' }
GtSpotterSearchFinished >> processors: anObject [
	processors := anObject
]

{ #category : 'accessing' }
GtSpotterSearchFinished >> query [
	^ query
]

{ #category : 'accessing' }
GtSpotterSearchFinished >> query: anObject [
	query := anObject
]
