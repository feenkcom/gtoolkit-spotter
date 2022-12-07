Trait {
	#name : #TGtSpotterFilter,
	#category : #'GToolkit-Spotter-Filters'
}

{ #category : #evaluating }
TGtSpotterFilter >> applyInScope: aStream context: aSpotterContext [
	^ self explicitRequirement
]
