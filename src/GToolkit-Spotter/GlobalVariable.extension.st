Extension { #name : #GlobalVariable }

{ #category : #'*GToolkit-Spotter' }
GlobalVariable >> gtSpotterActDefaultFrom: aSpotterElement [
	GtInspector openOn: self value from: aSpotterElement
]

{ #category : #'*GToolkit-Spotter' }
GlobalVariable >> gtSpotterClassFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 50;
		title: 'Class';
		items: [ {self value class} ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter' }
GlobalVariable >> gtSpotterForReferencesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 130;
		title: 'References';
		items: [ (SystemNavigation default allReferencesTo: self) collect: #compiledMethod ];
		itemName: [ :method | method gtDisplayString ];
		filterBySubstring
]
