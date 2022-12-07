Extension { #name : #GtResourcesUtility }

{ #category : #'*GToolkit-Spotter-Extensions' }
GtResourcesUtility >> spotterForPathResourcesFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Resource from Path object';
		priority: 1;
		itemName: #basename;
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter item: [ :aFilter :aContext | 
			(aContext textTrimmed beginsWith: 'Path') ifTrue: [
				| aPath |
				aPath := GtResourcesUtilityPathExtractor new
					pathFrom: aContext textTrimmed.
				aPath ifNotNil: [ 
					| aFile |
					aFile := self resourceAtPath: aPath.
					aFile exists ifTrue: [ aFilter value: aFile ] ] ] ]
]

{ #category : #'*GToolkit-Spotter-Extensions' }
GtResourcesUtility >> spotterForStringResourcesFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Resource from file or directory name';
		priority: 2;
		itemName: #basename;
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter item: [ :aFilter :aContext | 
			| aFile |
			aContext textTrimmed ifNotEmpty: [ :aText |
				aFile := self resourceAtPath: aContext textTrimmed.
				aFilter value: aFile ] ]
]
