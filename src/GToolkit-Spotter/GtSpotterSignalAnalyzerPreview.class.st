Class {
	#name : #GtSpotterSignalAnalyzerPreview,
	#superclass : #Object,
	#traits : 'TGtSpotterSignalsView',
	#classTraits : 'TGtSpotterSignalsView classTrait',
	#instVars : [
		'signals'
	],
	#category : #'GToolkit-Spotter-Logging'
}

{ #category : #'instance creation' }
GtSpotterSignalAnalyzerPreview class >> fromSignals: aCollection [
	<return: #Array of: #GtSpotterSignalAnalyzerProcessor>
	| theGroups aFilteredCollection thePreviews |
	aFilteredCollection := aCollection select: #isPreviewSignal.
	theGroups := aFilteredCollection groupedBy: #candidate.
	thePreviews := theGroups 
		collect: [ :eachCollection | 
			eachCollection sort: [ :a :b | a timestamp < b timestamp ].
			self new signals: eachCollection ]
		as: Array.
	thePreviews := thePreviews sort: [ :a :b | a startTimestamp < b startTimestamp ].
	^ thePreviews
]

{ #category : #'api - accessing' }
GtSpotterSignalAnalyzerPreview >> candidate [
	^ self signals anyOne candidate
]

{ #category : #'api - accessing' }
GtSpotterSignalAnalyzerPreview >> numberOfCandidates [
	^ 1
]

{ #category : #accessing }
GtSpotterSignalAnalyzerPreview >> signals [
	^ signals
]

{ #category : #accessing }
GtSpotterSignalAnalyzerPreview >> signals: anObject [
	signals := anObject
]

{ #category : #'api - accessing' }
GtSpotterSignalAnalyzerPreview >> title [
	^ 'Preview for: ', self candidate item asString
]
