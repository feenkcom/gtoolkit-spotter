Extension { #name : #GtSpotterStart }

{ #category : #'*GToolkit-Spotter' }
GtSpotterStart >> gtSpotterClipboardFor: aStep [
	<gtSearch>
	aStep listProcessor
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
GtSpotterStart >> gtSpotterForClassesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 10;
		items: [ Smalltalk allClassesAndTraits ];
		title: 'Classes';
		filter: GTFilterSubstring;
		itemIcon: #systemIcon;
		keyBinding: $b meta;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GtSpotterStart >> gtSpotterForDirectoriesFor: aStep [
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
GtSpotterStart >> gtSpotterForFilesFor: aStep [
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
GtSpotterStart >> gtSpotterForGlobalVarsFor: aStep [
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
GtSpotterStart >> gtSpotterForMessagesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 35;
		title: 'Messages';
		filter: GTNullFilter
			item:
				[ :filter :context | GTSelector substring: context textTrimmed filter: filter ];
		actLogic: [ :each :step | 
			step exit.
			self systemNavigation browseAllImplementorsOf: each name ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GtSpotterStart >> gtSpotterForMetacelloConfigurationsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 86;
		title: 'Metacello Configurations';
		allCandidates: [ BaselineOf allSubclasses ];
		itemName: [ :each | each configuration class name ];
		itemIcon: [ Smalltalk ui icons iconNamed: #config ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GtSpotterStart >> gtSpotterForPackagesFor: aStep [
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
GtSpotterStart >> gtSpotterForPragmasFor: aStep [
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
GtSpotterStart >> gtSpotterForReferencesFor: aStep [
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
GtSpotterStart >> gtSpotterForSendersFor: aStep [
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
GtSpotterStart >> gtSpotterForToolsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 1;
		allCandidates: [ {GtPlaygroundStencil new . GtCoderStencil new . GtMonitorStencil new . GtTranscriptStencil new } ];
		title: 'Tools';
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'*GToolkit-Spotter' }
GtSpotterStart >> gtSpotterImplementorsFor: aStep [
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
