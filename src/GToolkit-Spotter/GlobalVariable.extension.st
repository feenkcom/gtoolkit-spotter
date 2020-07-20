Extension { #name : #GlobalVariable }

{ #category : #'*GToolkit-Spotter' }
GlobalVariable >> gtSpotterActDefaultFrom: aSpotterElement [
	GtInspector openOn: self value from: aSpotterElement
]

{ #category : #'*GToolkit-Spotter' }
GlobalVariable >> gtSpotterClassFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 50;
		title: 'Class';
		allCandidates: [ {self value class} ];
		itemIcon: #systemIcon;
		filter: GtFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
GlobalVariable >> gtSpotterForReferencesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 130;
		title: 'References';
		allCandidates: [ (SystemNavigation default allReferencesTo: self)
				collect: #compiledMethod ];
		itemName: [ :method | method gtDisplayString ];
		filter: GtFilterSubstring
]
