Extension { #name : #GlobalVariable }

{ #category : #'*GToolkit-Spotter-Extensions' }
GlobalVariable >> gtSpotterActDefaultFrom: aSpotterElement [
	^ BlSpace showTool: [ self value gtDefaultInspectorTool ] from: aSpotterElement
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
		items: [ SystemNavigation default allReferencesTo: self ];
		itemName: [ :method | method gtDisplayString ];
		filterBySubstring
]
