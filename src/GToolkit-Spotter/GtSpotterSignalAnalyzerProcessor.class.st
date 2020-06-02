Class {
	#name : #GtSpotterSignalAnalyzerProcessor,
	#superclass : #Object,
	#traits : 'TGtSpotterSignalsView',
	#classTraits : 'TGtSpotterSignalsView classTrait',
	#instVars : [
		'signals'
	],
	#category : #'GToolkit-Spotter-Logging'
}

{ #category : #'instance creation' }
GtSpotterSignalAnalyzerProcessor class >> fromSignals: aCollection [
	<return: #Array of: #GtSpotterSignalAnalyzerProcessor>
	| theGroups aFilteredCollection |
	aFilteredCollection := aCollection select: #isFilterSignal.
	theGroups := aFilteredCollection groupedBy: #processor.
	^ theGroups 
		collect: [ :eachCollection | 
			eachCollection sort: [ :a :b | a timestamp < b timestamp ].
			self new signals: eachCollection ]
		as: Array.
]

{ #category : #'api - accessing' }
GtSpotterSignalAnalyzerProcessor >> candidates [
	^ self processor allFilteredCandidates
]

{ #category : #'gt-extension' }
GtSpotterSignalAnalyzerProcessor >> gtCandidatesFor: aView [
	<gtView>
	self processor ifNil: [ ^ aView empty ].
	^ aView forward 
		title: 'All Filtered Candidates';
		object: [ self processor ];
		view: #gtAllFilteredCandidatesFor:
]

{ #category : #'api - accessing' }
GtSpotterSignalAnalyzerProcessor >> numberOfCandidates [
	^ self candidates size
]

{ #category : #printing }
GtSpotterSignalAnalyzerProcessor >> printOn: aStream [
	self signals ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPutAll: self title asString
]

{ #category : #accessing }
GtSpotterSignalAnalyzerProcessor >> processor [
	^ self signals anyOne processor
]

{ #category : #accessing }
GtSpotterSignalAnalyzerProcessor >> signals [
	^ signals
]

{ #category : #accessing }
GtSpotterSignalAnalyzerProcessor >> signals: anObject [
	signals := anObject
]

{ #category : #'api - accessing' }
GtSpotterSignalAnalyzerProcessor >> title [
	^ self processor title
]
