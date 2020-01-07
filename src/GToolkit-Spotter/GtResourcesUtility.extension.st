Extension { #name : #GtResourcesUtility }

{ #category : #'*GToolkit-Spotter' }
GtResourcesUtility >> spotterForPathResourcesFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Resources';
		itemName: #basename;
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
		title: 'Resources';
		itemName: #basename;
		filter: GTNullFilter item: [ :aFilter :aContext | 
			| aFile |
			aContext textTrimmed ifNotEmpty: [ :aText |
				aFile := self resourceAtPath: aContext textTrimmed.
				aFile exists ifTrue: [ aFilter value: aFile ] ] ]
]
