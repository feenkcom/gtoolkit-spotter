Extension { #name : 'GtResourcesUtilityLocation' }

{ #category : '*GToolkit-Spotter' }
GtResourcesUtilityLocation >> spotterForPathResourcesFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Resource from Path object';
		priority: 1;
		filter: GtNullFilter item: [ :aFilter :aContext | 
			(aContext textTrimmed beginsWith: 'Path') ifTrue: [
				| aPath |
				aPath := GtResourcesUtilityPathExtractor new
					pathFrom: aContext textTrimmed.
				aPath ifNotNil: [ 
					| aResult |
					aResult := self resourceAtPath: aPath.
					aFilter value: aResult ] ] ]
]

{ #category : '*GToolkit-Spotter' }
GtResourcesUtilityLocation >> spotterForStringResourcesFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Resource from file or directory name';
		priority: 2;
		filter: GtNullFilter item: [ :aFilter :aContext | 
			| aResult |
			aContext textTrimmed ifNotEmpty: [ :aText |
				aResult := self resourceAtPath: aContext textTrimmed.
				aFilter value: aResult ] ]
]
