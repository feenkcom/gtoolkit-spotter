Class {
	#name : #GtSpotterStart,
	#superclass : #Object,
	#instVars : [
		'spotterModel'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #accessing }
GtSpotterStart >> concreteMethodsInContext: aContext usingFilter: aFilter [
	" return the concrete methods described by the expression (Class >> #Selector) - evaluate it savely "
	| classAndSelectorStrings class selector |
	classAndSelectorStrings := (aContext textTrimmed splitOn: '>>') collect: [ :each | each trimBoth ].
	
	" check preconditions "
	classAndSelectorStrings size = 2 ifFalse: [ ^ self ].
	classAndSelectorStrings second size < 2 ifTrue: [ ^ self ].

	" retrieve concrete class and selector - or saerch all behaviors "
	selector := classAndSelectorStrings second first = $# 
		ifTrue: [ classAndSelectorStrings second allButFirst asSymbol ]
		ifFalse: [ classAndSelectorStrings second asSymbol ].
	
	(class := Smalltalk classNamed: classAndSelectorStrings first) ifNil: [ 
		SystemNavigation default allBehaviorsDo: [ :aClass |
			aClass methodsDo: [ :method |
				method selector = selector ifTrue: [ aFilter value: method ] ] ].
		^ self ].
	
	
	" retrieve the compiled method in the class and class hierarchy "
	class withAllSuperclassesDo: [ :aClass |
		aFilter value: ([ aClass compiledMethodAt: selector ] on: Error do: [ ^ self ]) ]
]

{ #category : #spotter }
GtSpotterStart >> fileReferencesBy: aSelector inContext: aSpotterContext usingFilter: aBlock [
	| split rootDirectory query |
	split := aSpotterContext textLowercase piecesCutWhere: [ :a :b | a = FileSystem disk delimiter ].
	split size < 1
		ifTrue: [ 
			query := aSpotterContext textLowercase.
			rootDirectory := FileSystem workingDirectory ]
		ifFalse: [ 
			(split last last = FileSystem disk delimiter)
				ifTrue: [ 
					query := ''.
					rootDirectory := aSpotterContext textLowercase asFileReference ]
				ifFalse: [ 
					query := split last.
					rootDirectory := ('' join: split allButLast) asFileReference ] ].
	rootDirectory exists ifFalse: [ ^ self ].
	self flag: 'this is an ugly hack for #queryForFileReference. This iterator has to manipulate the query in order for the filter to work properly'.
	aSpotterContext cacheAt: #queryForFileReference put: query.
	(rootDirectory perform: aSelector) do: aBlock
]

{ #category : #printing }
GtSpotterStart >> gtDisplayOn: stream [
	stream nextPutAll: 'Spotter'
]

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

{ #category : #accessing }
GtSpotterStart >> gtSpotterConcreteMethodFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 30;
		title: 'Methods';
		filter: GTNullFilter
			item:
				[ :filter :context | self concreteMethodsInContext: context usingFilter: filter ];
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
GtSpotterStart >> gtSpotterForResourcesUtilityFromPathFor: aStep [
	<gtSearch>
	^ (GtResourcesUtility default spotterForPathResourcesFor: aStep)
		priority: 40;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #'*GToolkit-Spotter' }
GtSpotterStart >> gtSpotterForResourcesUtilityFromStringFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Resource from file or directory name';
		priority: 2;
		itemName: #basename;
		wantsToDisplayOnEmptyQuery: false;
		filter: GTNullFilter item: [ :aFilter :aContext | 
			| aFile |
			aContext textTrimmed ifNotEmpty: [ :aText |
				aFile := GtResourcesUtility default resourceAtPath: aContext textTrimmed.
				aFile exists ifTrue: [ aFilter value: aFile ] ] ]
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
		allCandidates: [ {GtPlaygroundStencil new . GtCoderStencil new . GtMonitorStencil new . GtRlGToolkitExamplesExplorer buildForGToolkitProject . GtTranscriptStencil new } ];
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

{ #category : #'*GToolkit-Spotter' }
GtSpotterStart >> spotterForVectorIconFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		title: 'Vector Icons';
		priority: 100;
		allCandidates: [ BrGlamorousVectorIcons allIcons ];
		itemName: #key;
		itemIcon: [ :anAssoc | anAssoc value ];
		filter: GTFilterSubstring;
		actLogic: [ :item :step | 
			step exit.
			(BrGlamorousVectorIcons class >> item key) gtInspect ]
]

{ #category : #accessing }
GtSpotterStart >> spotterModel [
	self
		assert: [ spotterModel isNotNil ]
		description: [ 'Spotter must not be nil' ].

	^ spotterModel
]

{ #category : #accessing }
GtSpotterStart >> spotterModel: aGtSpotter [
	spotterModel := aGtSpotter
]
