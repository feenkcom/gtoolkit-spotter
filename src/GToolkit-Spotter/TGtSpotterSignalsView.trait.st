Trait {
	#name : #TGtSpotterSignalsView,
	#category : #'GToolkit-Spotter-Logging'
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
		items: [ self signals ];
		column: 'Timestamp' item: [ :each | each timestamp ];
		column: 'Process' item: [ :each | each processId ];
		column: 'Type' item: [ :each | each name ]
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
