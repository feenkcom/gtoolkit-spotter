Extension { #name : #MCPackage }

{ #category : #'*GToolkit-Spotter' }
MCPackage >> gtSpotterForPackageFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 2;
		title: 'Packages';
		allCandidates: [ Array with: self correspondingRPackage ];
		itemName: [ :package | package name ];
		itemIcon: [ Smalltalk ui icons iconNamed: #packageIcon ];
		filter: GTFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
MCPackage >> gtSpotterMonticelloWorkingCopyFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 1;
		title: 'Monticello Working Copy';
		allCandidates: [ Array with: self workingCopy ];
		itemIcon: [ Smalltalk ui icons iconNamed: #versionControlIcon ];
		filter: GTFilterSubstring
]
