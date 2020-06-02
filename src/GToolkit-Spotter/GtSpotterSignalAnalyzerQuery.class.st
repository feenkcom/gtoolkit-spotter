Class {
	#name : #GtSpotterSignalAnalyzerQuery,
	#superclass : #Object,
	#traits : 'TGtSpotterSignalsView',
	#classTraits : 'TGtSpotterSignalsView classTrait',
	#instVars : [
		'signals',
		'processors'
	],
	#category : #'GToolkit-Spotter-Logging'
}

{ #category : #factory }
GtSpotterSignalAnalyzerQuery class >> fromSignals: aCollection [
	<return: #Array of: #GtSpotterSignalAnalyzerQuery>
	| theGroups |
	theGroups := aCollection groupedBy: #context.
	^ theGroups 
		collect: [ :eachCollection | 
			eachCollection sort: [ :a :b | a timestamp < b timestamp ].
			self new signals: eachCollection ]
		as: Array.
	
]

{ #category : #'gt-extensions' }
GtSpotterSignalAnalyzerQuery >> gtProcessorsFor: aView [
	<gtView>
	self signals ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Procesors';
		priority: 1;
		items: [ self processors ];
		column: 'Title' item: #title;
		column: 'Duration' item: #duration format: [ :each | 
			| aText |
			aText := each humanReadablePrintString asRopedText.
			each < 1 milliSecond ifTrue: [ aText foreground: BrGlamorousColors disabledButtonTextColor ].
			aText ];
		column: 'Candidates' item: #numberOfCandidates width: 50
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

{ #category : #accessing }
GtSpotterSignalAnalyzerQuery >> processors [
	<return: #Array of: #GtSpotterSignalAnalyzerProcessor>
	^ processors
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
]
