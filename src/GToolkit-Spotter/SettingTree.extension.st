Extension { #name : #SettingTree }

{ #category : #'*GToolkit-Spotter' }
SettingTree >> gtSpotterForSettingsFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 0;
		title: 'Settings';
		items: [ self nodeList ];
		itemName: [ :each | each spotterLabel ];
		filterBySubstring
]
