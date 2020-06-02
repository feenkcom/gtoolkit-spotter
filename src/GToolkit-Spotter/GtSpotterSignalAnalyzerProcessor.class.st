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
	| theGroups aFilteredCollection theProcessors |
	aFilteredCollection := aCollection select: #isFilterSignal.
	theGroups := aFilteredCollection groupedBy: #processor.
	theProcessors := theGroups 
		collect: [ :eachCollection | 
			eachCollection sort: [ :a :b | a timestamp < b timestamp ].
			self new signals: eachCollection ]
		as: Array.
	theProcessors := theProcessors sort: [ :a :b | a startTimestamp < b startTimestamp ].
	^ theProcessors
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
		priority: 1;
		object: [ self processor ];
		view: #gtAllFilteredCandidatesFor:
]

{ #category : #'gt-extensions' }
GtSpotterSignalAnalyzerProcessor >> gtDefiningMethodFor: aView [
	<gtView>
	self signals ifNil: [ ^ aView empty ].
	self processor hasDefiningMethod ifFalse: [ ^ aView empty ].
	^ aView forward
		title: 'Method';
		priority: 2;
		object: [ self processor ];
		view: #gtDefiningMethodFor:

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
