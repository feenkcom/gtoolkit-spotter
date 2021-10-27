Class {
	#name : #GtSpotterCandidateLink,
	#superclass : #DoubleLink,
	#instVars : [
		'processorLink',
		'weight',
		'renderingProcessorLink'
	],
	#category : 'GToolkit-Spotter-Utils'
}

{ #category : #comparing }
GtSpotterCandidateLink >> < anotherCandidateLink [

	^ self weight < anotherCandidateLink weight
]

{ #category : #comparing }
GtSpotterCandidateLink >> > anotherCandidateLink [

	^ self weight > anotherCandidateLink weight
]

{ #category : #converting }
GtSpotterCandidateLink >> asGtSpotterCandidateLink [

	^ self
]

{ #category : #accessing }
GtSpotterCandidateLink >> candidate [
	^ self value
]

{ #category : #copying }
GtSpotterCandidateLink >> copy [
	|link|
	link := self class value: self value.
	link privateProcessorLink: processorLink.
	link privateRenderingProcessorLink: renderingProcessorLink.
	link weight: weight.
	^ link
]

{ #category : #printing }
GtSpotterCandidateLink >> gtDisplayOn: stream [
	stream nextPutAll: 'Candidate link: '.
	self value gtDisplayOn: stream 
]

{ #category : #testing }
GtSpotterCandidateLink >> isFirst [

	^ (self previousLink processorLink = self processorLink) not
]

{ #category : #accessing }
GtSpotterCandidateLink >> next [
	^ self nextLink
]

{ #category : #accessing }
GtSpotterCandidateLink >> previous [
	^ self previousLink
]

{ #category : #private }
GtSpotterCandidateLink >> privateProcessorLink: aLink [

	processorLink := aLink
]

{ #category : #private }
GtSpotterCandidateLink >> privateRenderingProcessorLink: aLink [

	renderingProcessorLink := aLink
]

{ #category : #accessing }
GtSpotterCandidateLink >> processor [

	^ self processorLink value
]

{ #category : #accessing }
GtSpotterCandidateLink >> processorLink [
	^ processorLink
]

{ #category : #accessing }
GtSpotterCandidateLink >> processorLink: anObject [

	"we set rendering processor only if one is not set. it allows to have a collection of items,
	that have different rendering processors"
	
	processorLink ifNil: [ self renderingProcessor: anObject ].
	processorLink := anObject.
	
]

{ #category : #accessing }
GtSpotterCandidateLink >> renderingProcessor [

	renderingProcessorLink ifNil: [ self renderingProcessor: processorLink ].
	^ renderingProcessorLink value
]

{ #category : #accessing }
GtSpotterCandidateLink >> renderingProcessor: aProcessorLink [

	renderingProcessorLink ifNil: [ renderingProcessorLink := aProcessorLink processor asGtSpotterProcessorLink ].
	processorLink ifNil: [ processorLink := aProcessorLink ]
]

{ #category : #accessing }
GtSpotterCandidateLink >> weight [

	^ weight
]

{ #category : #accessing }
GtSpotterCandidateLink >> weight: anObject [ 

	weight := anObject
]
