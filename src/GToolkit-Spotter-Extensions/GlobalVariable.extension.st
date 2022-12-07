Extension { #name : #GlobalVariable }

{ #category : #'*GToolkit-Spotter-Extensions' }
GlobalVariable >> gtSpotterActDefaultFrom: aSpotterElement [
	GtInspector openOn: self value from: aSpotterElement
]

{ #category : #'*GToolkit-Spotter-Extensions' }
GlobalVariable >> gtSpotterClassFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 50;
		title: 'Class';
		items: [ {self value class} ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter-Extensions' }
GlobalVariable >> gtSpotterForReferencesFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 130;
		title: 'References';
		items: [ (SystemNavigation default allReferencesTo: self) collect: #compiledMethod ];
		itemName: [ :method | method gtDisplayString ];
		filterBySubstring
]
