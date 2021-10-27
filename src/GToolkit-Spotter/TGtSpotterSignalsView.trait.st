Trait {
	#name : #TGtSpotterSignalsView,
	#category : 'GToolkit-Spotter-Logging'
}

{ #category : #'api - time' }
TGtSpotterSignalsView >> duration [
	^ self stopTimestamp - self startTimestamp
]

{ #category : #'gt-extensions' }
TGtSpotterSignalsView >> gtSignalsFor: aView [
	<gtView>
	self signals ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Signals';
		priority: 10;
		items: [ self signals ];
		column: 'Timestamp' text: [ :each | each timestamp ];
		column: 'Process' text: [ :each | each processId ];
		column: 'Type' text: [ :each | each name ]
]

{ #category : #accessing }
TGtSpotterSignalsView >> signals [
	^ self explicitRequirement
]

{ #category : #'api - time' }
TGtSpotterSignalsView >> startTimestamp [
	^ self signals first timestamp
]

{ #category : #'api - time' }
TGtSpotterSignalsView >> stopTimestamp [
	^ self signals last timestamp
]
