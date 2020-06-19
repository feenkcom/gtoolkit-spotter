Extension { #name : #GTSpotter }

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterAddressBookFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority:  -1;
		allCandidates: [ :x | {GtABAddressBook default} ];
		title: 'Address books';
		itemName: [ :addressBook | addressBook label ];
		matchSubstring;
		candidatesLimit: 5;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterCatalogProjectsFor: aStep [
	<gtSearch>
	CatalogSettings displayCatalogProjectsInSpotter
		ifFalse: [ ^ self ].
	aStep listProcessor
		priority: 90;
		allCandidates: [ CatalogProvider default projects ];
		title: 'Catalog Projects';
		itemName: [ :item | item name ];
		itemIcon: [ :item | CatalogBrowser iconFor: item ];
		filter: GTFilterSubstring;
		actLogic: [ :item | 
			aStep exit.
			(UIManager default
				confirm: 'Would you like to install ' , item name , '?')
				ifTrue: [ item installStableVersion.
					UIManager inform: item name , ' installed' ] ];
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterClipboardFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 90;
		title: 'Clipboard History';
		items: [ Clipboard default recentItems ];
		itemName: [ :item | item asString contractTo: 100 ];
		itemFilterName: [ :item | item asString ];
		filter: GTFilterSubstrings;
		actLogic: [ :item :step | 
			step exit.
			item asString inspect ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterConcreteMethodFor: aStep [
	<gtSearch>
	self flag: #specialFilter.
	^ aStep listProcessor
		priority: 30;
		title: 'Methods';
		filter: GTNullFilter
			item:
				[ :filter :context | self concreteMethodsInContext: context usingFilter: filter ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterDirtyMonticelloPackagesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 85;
		allCandidates: [ MCWorkingCopy allManagers select: #modified ];
		title: 'Dirty Monticello packages';
		itemIcon: [ Smalltalk ui icons iconNamed: #dirtyPackageIcon ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter class >> gtSpotterExtensionsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 50;
		allCandidates: [ self spotterExtendingMethods ];
		title: 'Extensions';
		itemName: [ :each | each gtDisplayString ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterForCachedPlaygroundPagesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 100;
		allCandidates: [ GTPlayBook instance pages ];
		title: 'Playground cached pages';
		itemName: [ :page | page content asString contractTo: 100 ];
		filter: GTFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterForClassesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 10;
		allCandidates: [ Smalltalk allClassesAndTraits ];
		title: 'Classes';
		filter: GTFilterSubstring;
		itemIcon: #systemIcon;
		keyBinding: $b meta;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterForDirectoriesFor: aStep [
	<gtSearch>
	self flag: #specialFilter.
	aStep listProcessor
		priority: 50;
		title: 'Directories';
		itemIcon: [ GLMUIThemeExtraIcons glamorousFolder ];
		itemFilterName: [ :reference | reference basename ];
		filter: GTFilterFileReference
			item: [ :filter :context | 
			self
				fileReferencesBy: #directories
				inContext: context
				usingFilter: filter ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterForExpressionsFor: aStep [
	<gtSearch>
	self flag: #specialFilter.
	aStep listProcessor
		priority: 1;
		title: 'Calculator';
		filter: GTNullFilter
			item:
				[ :filter :context | self evaluateExpressionInContext: context usingFilter: filter ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterForFilesFor: aStep [
	<gtSearch>
	self flag: #specialFilter.
	aStep listProcessor
		priority: 40;
		title: 'Files';
		itemIcon: [ GLMUIThemeExtraIcons glamorousBrowse ];
		itemFilterName: [ :reference | reference basename ];
		filter: GTFilterFileReference
			item:
				[ :filter :context | self fileReferencesBy: #files inContext: context usingFilter: filter ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterForGlobalVarsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 40;
		allCandidates: [ Smalltalk globals associations
				select:
					[ :assoc | assoc value isBehavior not and: [ assoc value isTrait not ] ] ];
		title: 'Global variables';
		itemName: [ :global | global key ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterForMessagesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 35;
		title: 'Messages';
		filter: GTNullFilter
			item:
				[ :filter :context | GtSelector substring: context textTrimmed filter: filter ];
		actLogic: [ :each :step | 
			step exit.
			self systemNavigation browseAllImplementorsOf: each name ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterForMetacelloConfigurationsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 86;
		title: 'Metacello Configurations';
		allCandidates: [ Smalltalk allClasses
				select: [ :each | 
					(each respondsTo: #isMetacelloConfig)
						and: [ each isMetacelloConfig
								and: [ each name beginsWith: 'ConfigurationOf' ] ] ]
				thenCollect: #project ];
		itemName: [ :each | each configuration class name ];
		itemIcon: [ Smalltalk ui icons iconNamed: #config ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterForPackagesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 20;
		allCandidates: [ RPackageOrganizer default packages ];
		title: 'Packages';
		itemName: [ :package | package name ];
		itemIcon: [ Smalltalk ui icons iconNamed: #packageIcon ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterForPragmasFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 40;
		allCandidates: [ PragmaType all ];
		title: 'Pragmas';
		itemName: [ :pragma | pragma keyword ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterForReferencesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 32;
		title: 'References';
		filter: GTNullFilter
			item: [ :filter :context | 
			self class environment
				at: context textTrimmed
				ifPresent:
					[ :class | SystemNavigation default allReferencesTo: class binding do: filter ] ];
		keyBinding: $n shift meta;
		itemName: [ :method | method gtDisplayString ]
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterForRepositoriesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 87;
		title: 'Monticello Repositories';
		allCandidates: [ MCRepositoryGroup default repositories ];
		itemIcon: #systemIcon;
		wantsToDisplayOnEmptyQuery: false;
		filter: GTFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterForSendersFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 31;
		title: 'Senders';
		filter: GTNullFilter
			item: [ :filter :context | 
			SystemNavigation default
				allSendersToString: context textTrimmed
				do: filter ];
		keyBinding: $n meta;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterForStashedPlaygroundPagesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 100;
		allCandidates: [ | stashFiles |
			stashFiles := GTPlayBook stashDirectory files
				select: [ :each | each extension = GTPlayPage fileExtension ].
			stashFiles
				collect: [ :file | 
					(GTPlayPage fromFileReference: file)
						title: (file basename copyUpTo: $-) ] ];
		title: 'Playground named pages';
		itemName: [ :page | page title , ' - ' , page content asString contractTo: 100 ];
		filter: GTFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterHistoryFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 8;
		allCandidates: [ self history asArray
				select: [ :each | each isNotNil and: [ each value isNotNil ] ] ];
		title: 'History';
		itemName: [ :item | 
			item class = GTSpotterProcessorLink
				ifTrue: [ " HACK: this triggers a recursion ! ... but processor is undefined for aCandidate " item processor itemNameFor: item value ]
				ifFalse: [ item gtDisplayString ] ];
		filter: GTFilterSubstring
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterImplementorsFor: aStep [
	<gtSearch>
	self flag: #specialFilter.
	aStep listProcessor
		priority: 30;
		title: 'Implementors';
		filter: GTFilterImplementor
			item: [ :filter :context | 
			SystemNavigation default
				allBehaviorsDo: [ :class | class localMethods do: filter ] ];
		keyBinding: $m meta;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterMooseModelsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 8;
		title: 'Moose Models';
		itemName: [ :pragma | pragma name ];
		filter: GTFilterSubstring
			item: [ :filter :context | MooseModel root allModels do: filter ];
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterStfxFor: aStep [
	<gtSearch>
	self flag: #specialFilter.
	^ aStep listProcessor
		priority: 30;
		title: 'ws.stfx.eu';
		filter: GTNullFilter
			item: [ :filter :context | 
			(context textTrimmed beginsWith: 'http://ws.stfx.eu')
				ifTrue: [ GTPlayPage loadFromPublishUrl: context textTrimmed thenDo: filter ] ]
]

{ #category : #'*GToolkit-Spotter' }
GTSpotter >> gtSpotterXdocFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 30;
		title: 'XDoc';
		itemName: [ :aFileInfo | aFileInfo titleAndAuthor ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GTNullFilter
			item: [ :filter :context | 
			(context textTrimmed beginsWith: XdClientSettings xdServerUrlString)
				ifTrue:
					[ XdClient downloadFileInfo: context textTrimmed thenDo: filter ] ];
		actLogic: [ :aFileInfo :step | 
			step exit.
			(XdClient new downloadXDocUsingFileInfo: aFileInfo) open ]
]
