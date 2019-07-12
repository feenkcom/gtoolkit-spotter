Extension { #name : #SettingTree }

{ #category : #'*GToolkit-Spotter' }
SettingTree >> gtSpotterForSettingsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 0;
		title: 'Settings';
		allCandidates: [ self nodeList ];
		itemName: [ :each | each spotterLabel ];
		filter: GTFilterSubstring
]
