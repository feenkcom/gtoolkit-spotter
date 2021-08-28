Class {
	#name : 'GtSpotterSignalAnalyzer',
	#superclass : 'Object',
	#traits : 'TGtSpotterSignalsView',
	#classTraits : 'TGtSpotterSignalsView classTrait',
	#instVars : [
		'signals',
		'queries'
	],
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : 'instance creation' }
GtSpotterSignalAnalyzer class >> fromMemoryLogger: aMemoryLogger [
	^ self signals: aMemoryLogger recordings
]

{ #category : 'instance creation' }
GtSpotterSignalAnalyzer class >> signals: aCollection [
	^ self new signals: aCollection
]

{ #category : 'gt-extensions' }
GtSpotterSignalAnalyzer >> gtQueriesFor: aView [
	<gtView>
	self queries ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Queries';
		priority: 1;
		items: [ self queries ];
		column: 'Query' item: #query width: 150;
		column: 'Duration' item: #duration format: #humanReadablePrintString;
		column: 'Processors + Previews Duration' item: #processorsAndPreviewsDuration format: #humanReadablePrintString
]

{ #category : 'accessing' }
GtSpotterSignalAnalyzer >> queries [
	<return: #Collection of: #GtSpotterSignalAnalyzerQuery>
	^ queries
]

{ #category : 'accessing' }
GtSpotterSignalAnalyzer >> signals [
	^ signals
]

{ #category : 'accessing' }
GtSpotterSignalAnalyzer >> signals: aCollection [
	signals := aCollection.
	queries := GtSpotterSignalAnalyzerQuery fromSignals: aCollection.
]
