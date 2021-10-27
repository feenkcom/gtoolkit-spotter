Class {
	#name : #GtSpotterSignalAnalyzerQuery,
	#superclass : #Object,
	#traits : 'TGtSpotterSignalsView',
	#classTraits : 'TGtSpotterSignalsView classTrait',
	#instVars : [
		'signals',
		'processors',
		'previews',
		'processorsAndPreviews'
	],
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : #factory }
GtSpotterSignalAnalyzerQuery class >> fromSignals: aCollection [
	<return: #Array of: #GtSpotterSignalAnalyzerQuery>
	| theGroups theQueries |
	theGroups := aCollection groupedBy: #context.
	theQueries := theGroups 
		collect: [ :eachCollection | 
			eachCollection sort: [ :a :b | a timestamp < b timestamp ].
			self new signals: eachCollection ]
		as: Array.
	theQueries sort: [ :a :b | a startTimestamp < b startTimestamp ].
	^ theQueries
	
]

{ #category : #'gt-extensions' }
GtSpotterSignalAnalyzerQuery >> gtProcessorsFor: aView [
	<gtView>
	self signals ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Procesors + Previews';
		priority: 1;
		items: [ self processorsAndPreviews ];
		column: 'Title' text: #title;
		column: 'Duration' text: [ :each | 
			| aText |
			aText := each duration humanReadablePrintString asRopedText.
			each duration < 1 milliSecond
				ifTrue: [ aText foreground: BrGlamorousColors disabledButtonTextColor ].
			aText ];
		column: 'Candidates' text: #numberOfCandidates width: 50
]

{ #category : #'api - accessing' }
GtSpotterSignalAnalyzerQuery >> previews [
	<return: #Array of: #GtSpotterSignalAnalyzerPreview>
	^ previews
]

{ #category : #printing }
GtSpotterSignalAnalyzerQuery >> printOn: aStream [
	self signals ifNil: [ ^ super printOn: aStream ].
	aStream
		nextPutAll: 'Query: ';
		print: self query;
		nextPutAll: ' for ';
		print: self duration
]

{ #category : #'api - accessing' }
GtSpotterSignalAnalyzerQuery >> processors [
	<return: #Array of: #GtSpotterSignalAnalyzerProcessor>
	^ processors
]

{ #category : #'api - accessing' }
GtSpotterSignalAnalyzerQuery >> processorsAndPreviews [
	^ processorsAndPreviews
]

{ #category : #'api - time' }
GtSpotterSignalAnalyzerQuery >> processorsAndPreviewsDuration [
	self processorsAndPreviews ifEmpty: [ ^ 0 seconds ].
	^ self processorsAndPreviews sum: #duration
]

{ #category : #'api - accessing' }
GtSpotterSignalAnalyzerQuery >> query [
	^ self signals anyOne query
]

{ #category : #accessing }
GtSpotterSignalAnalyzerQuery >> signals [
	^ signals
]

{ #category : #accessing }
GtSpotterSignalAnalyzerQuery >> signals: aCollection [
	signals := aCollection.
	processors := GtSpotterSignalAnalyzerProcessor fromSignals: self signals.
	previews := GtSpotterSignalAnalyzerPreview fromSignals: self signals.
	processorsAndPreviews := processors, previews.
	processorsAndPreviews sort: [ :a :b | a startTimestamp < b startTimestamp ].
]
