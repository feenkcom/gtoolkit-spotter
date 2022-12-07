Extension { #name : #SettingNode }

{ #category : #'*GToolkit-Spotter-Extensions' }
SettingNode >> gtSpotterForSettingsFor: aSearch [
	<gtSearch>
	self allChildren isEmpty ifTrue: [ ^ aSearch empty ].
	^ aSearch list
		priority: 0;
		title: 'Children';
		items: [ self allChildren ];
		itemName: [ :each | each spotterLabel ];
		filterBySubstring
]

{ #category : #'*GToolkit-Spotter-Extensions' }
SettingNode >> spotterLabel [

	| label |
	label := self settingDeclaration label.
	^ self parentNode ifNil: [ label ] ifNotNil: [ self parentNode spotterLabel , '/' , label ]
]
