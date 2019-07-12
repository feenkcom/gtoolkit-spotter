Extension { #name : #SystemWindow }

{ #category : #'*GToolkit-Spotter' }
SystemWindow >> gtSpotterWindowsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 100;
		title: 'Windows';
		allCandidates: [ self class allSubInstances ];
		itemName: [ :window | '**' , window label , '**' ];
		filter: GTFilterSubstring
]
