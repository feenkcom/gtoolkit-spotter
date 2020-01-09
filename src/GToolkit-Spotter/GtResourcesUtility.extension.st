Extension { #name : #GtResourcesUtility }

{ #category : #'*GToolkit-Spotter' }
GtResourcesUtility >> spotterForPathResourcesFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Resource from Path object';
		priority: 1;
		itemName: #basename;
		wantsToDisplayOnEmptyQuery: false;
		filter: GTNullFilter item: [ :aFilter :aContext | 
			(aContext textTrimmed beginsWith: 'Path') ifTrue: [
				| aPath |
				aPath := GtResourcesUtilityPathExtractor new
					pathFrom: aContext textTrimmed.
				aPath ifNotNil: [ 
					| aFile |
					aFile := self resourceAtPath: aPath.
					aFile exists ifTrue: [ aFilter value: aFile ] ] ] ]
]

{ #category : #'*GToolkit-Spotter' }
GtResourcesUtility >> spotterForStringResourcesFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Resource from file or directory name';
		priority: 2;
		itemName: #basename;
		wantsToDisplayOnEmptyQuery: false;
		filter: GTNullFilter item: [ :aFilter :aContext | 
			| aFile |
			aContext textTrimmed ifNotEmpty: [ :aText |
				aFile := self resourceAtPath: aContext textTrimmed.
				aFilter value: aFile ] ]
]

{ #category : #'*GToolkit-Spotter' }
GtResourcesUtility >> spotterPathResourceAtLocationsFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Locations from Path object';
		priority: 4;
		wantsToDisplayOnEmptyQuery: false;
		items: [ self locations collect: [ :eachLocation | 
				GtResourcesUtilityResultContext new location: eachLocation ] ];
		filter: (GTFilterBlock new matcher: [ :anItem :aContext | 
			(aContext textTrimmed beginsWith: 'Path')
				ifTrue: [
					| aPath |
					aPath := GtResourcesUtilityPathExtractor new
						pathFrom: aContext textTrimmed.
					aPath 
						ifNil: [ false ]
						ifNotNil: [ anItem resourceAtPath: aContext textTrimmed. true ] ]
				ifFalse: [ false ] ])
]

{ #category : #'*GToolkit-Spotter' }
GtResourcesUtility >> spotterStringResourcesAtLocationsFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Locations from file or directory name';
		priority: 5;
		wantsToDisplayOnEmptyQuery: false;
		items: [ self locations collect: [ :eachLocation | 
				GtResourcesUtilityResultContext new location: eachLocation ] ];
		filter: (GTFilterBlock new matcher: [ :anItem :aContext | 
			aContext textTrimmed 
				ifNotEmpty: [ anItem resourceAtPath: aContext textTrimmed. true ]
				ifEmpty: [ false ] ])
]
