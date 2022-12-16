Class {
	#name : #GtSpotterCategoryActOn,
	#superclass : #GtSpotterActOn,
	#instVars : [
		'rawCategory'
	],
	#category : #'GToolkit-Spotter-Announcements'
}

{ #category : #'api - accessing' }
GtSpotterCategoryActOn >> objectToSend [
	<return: #Object>

	^ search
		categoryToActOn: rawCategory
		from: step
]

{ #category : #'api - accessing' }
GtSpotterCategoryActOn >> rawCategory [
	^ rawCategory
]

{ #category : #'api - accessing' }
GtSpotterCategoryActOn >> rawCategory: aSpotterCategory [
	rawCategory := aSpotterCategory
]

{ #category : #'api - accessing' }
GtSpotterCategoryActOn >> toolToSend [
	<return: #GtPhlowTool>

	^ search
		categoryToolToActOn: self objectToSend
		rawCategory: self rawCategory
		from: step
]
