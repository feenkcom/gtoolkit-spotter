Extension { #name : #SettingNode }

{ #category : #'*GToolkit-Spotter' }
SettingNode >> gtSpotterForSettingsFor: aStep [
	<gtSearch>
	self allChildren isEmpty
		ifTrue: [ ^ self ].
	aStep listProcessor
		priority: 0;
		title: 'Children';
		allCandidates: [ self allChildren ];
		itemName: [ :each | each spotterLabel ];
		filter: GtFilterSubstring
]
