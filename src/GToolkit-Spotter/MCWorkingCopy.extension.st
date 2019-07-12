Extension { #name : #MCWorkingCopy }

{ #category : #'*GToolkit-Spotter' }
MCWorkingCopy >> gtSpotterAllRepositoriesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 20;
		title: 'All other repositories';
		allCandidates: [ MCRepositoryGroup default repositories
				\ self repositoryGroup repositories ];
		itemName: [ :item | item description ];
		actLogic: [ :item :step | 
			step exit.
			self spotterCommit: self in: item ];
		filter: GTFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
MCWorkingCopy >> gtSpotterAncestorsFor: aStep [
	<gtSearch>
	self flag: #maybeRewriteForDirectStreaming.
	aStep listProcessor
		priority: 2;
		title: 'Ancestors';
		allCandidates: [ self allAncestors ];
		filter: GTFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
MCWorkingCopy >> gtSpotterMonticelloPackageFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 21;
		title: 'Monticello Package';
		allCandidates: [ Array with: self package ];
		itemIcon: [ Smalltalk ui icons iconNamed: #monticelloPackageIcon ];
		filter: GTFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
MCWorkingCopy >> gtSpotterPackageFor: aStep [
	<gtSearch>
	self flag: #maybeRewriteForDirectStreaming.
	aStep listProcessor
		priority: 21;
		title: 'Packages';
		allCandidates: [ self package correspondingRPackage
				ifNotNil: [ :rpackage | {rpackage} ]
				ifNil: [ {} ] ];
		itemName: [ :item | item name ];
		itemIcon: [ Smalltalk ui icons iconNamed: #packageIcon ];
		filter: GTFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
MCWorkingCopy >> gtSpotterPackageRepositoriesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 10;
		title: 'Package repositories';
		allCandidates: [ self repositoryGroup repositories ];
		itemName: [ :item | item description ];
		actLogic: [ :item :step | 
			step exit.
			self spotterCommit: self in: item ];
		filter: GTFilterSubstring
]
