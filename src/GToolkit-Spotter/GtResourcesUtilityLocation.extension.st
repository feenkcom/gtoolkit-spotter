Extension { #name : #GtResourcesUtilityLocation }

{ #category : #'*GToolkit-Spotter' }
GtResourcesUtilityLocation >> spotterForPathResourcesFor: aStep [
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
					| aResult |
					aResult := self resourceAtPath: aPath.
					aResult exists ifTrue: [ aFilter value: aResult file ] ] ] ]
]

{ #category : #'*GToolkit-Spotter' }
GtResourcesUtilityLocation >> spotterForStringResourcesFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Resources';
		itemName: #basename;
		filter: GTNullFilter item: [ :aFilter :aContext | 
			| aResult |
			aContext textTrimmed ifNotEmpty: [ :aText |
				aResult := self resourceAtPath: aContext textTrimmed.
				aResult exists ifTrue: [ aFilter value: aResult file ] ] ]
]
