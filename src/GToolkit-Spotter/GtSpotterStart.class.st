Class {
	#name : #GtSpotterStart,
	#superclass : #Object,
	#instVars : [
		'spotterModel'
	],
	#category : #'GToolkit-Spotter-Model'
}

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

{ #category : #spotter }
GtSpotterStart >> spotterClipboardFor: aStep [
	<spotterOrder: 90>
	^ aStep listProcessor
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

{ #category : #spotter }
GtSpotterStart >> spotterForClassesFor: aStep [
	<spotterOrder: 10>
	aStep listProcessor
			allCandidates: [ Smalltalk allClassesAndTraits ];
			title: 'Classes';
			filter: GTFilterSubstring;
			itemIcon: #systemIcon;
			keyBinding: $b meta;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> spotterForDirectoriesFor: aStep [
	<spotterOrder: 50>
	self flag: #specialFilter.
	aStep listProcessor
		title: 'Directories';
		itemIcon: [ GLMUIThemeExtraIcons glamorousFolder ];
		itemFilterName: [ :reference | reference basename ];
		filter: GTFilterFileReference item: [ :filter :context | 
			self fileReferencesBy: #directories inContext: context usingFilter: filter ];
		wantsToDisplayOnEmptyQuery: false	
]

{ #category : #spotter }
GtSpotterStart >> spotterForFilesFor: aStep [
	<spotterOrder: 40>
	self flag: #specialFilter.
	aStep listProcessor
		title: 'Files';
		itemIcon: [ GLMUIThemeExtraIcons glamorousBrowse ];
		itemFilterName: [ :reference | reference basename ];
		filter: GTFilterFileReference item: [ :filter :context | 
			self fileReferencesBy: #files inContext: context usingFilter: filter ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> spotterForGlobalVarsFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor
			allCandidates: [ Smalltalk globals associations select:[:assoc | 
			assoc value isBehavior not and:[ 
				assoc value isTrait not]] ];
			title: 'Global variables';
			itemName:[:global | global key ];
			filter: GTFilterSubstring;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> spotterForMessagesFor: aStep [
	<spotterOrder: 35>

	aStep listProcessor
		title: 'Messages';
		filter: GTNullFilter item: [ :filter :context | 
			GTSelector substring: context textTrimmed filter: filter ];
		actLogic: [ :each :step|
			step exit.
			self systemNavigation browseAllImplementorsOf: each name ];		
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> spotterForMetacelloConfigurationsFor: aStep [
	<spotterOrder: 86>
	aStep listProcessor
			title: 'Metacello Configurations';
			allCandidates: [ 
				Smalltalk allClasses select: [ :each | 
					(each respondsTo: #isMetacelloConfig) 
						and: [ each isMetacelloConfig
							and: [ each name beginsWith: 'BaselineOf' ] ] ]
					thenCollect: #project ];
			itemName: [ :each | each configuration class name ];
			itemIcon: [ Smalltalk ui icons iconNamed: #config ];
			filter: GTFilterSubstring;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> spotterForPackagesFor: aStep [
	<spotterOrder: 20>
	aStep listProcessor
			allCandidates: [ RPackageOrganizer default packages ];
			title: 'Packages';
			itemName: [ :package | package name ];
			itemIcon: [ Smalltalk ui icons iconNamed: #packageIcon ];
			filter: GTFilterSubstring;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> spotterForPragmasFor: aStep [
	<spotterOrder: 40>
	aStep listProcessor 
			allCandidates: [ PragmaType all ];
			title: 'Pragmas';
			itemName: [ :pragma | pragma keyword ];
			filter: GTFilterSubstring;
			wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> spotterForReferencesFor: aStep [
	<spotterOrder: 32>
	
	aStep listProcessor
		title: 'References';
		filter: GTNullFilter item: [ :filter :context |
			self class environment at: context textTrimmed ifPresent: [ :class |  
				SystemNavigation default allReferencesTo: class binding do: filter ] ];
		keyBinding: $n shift meta;
		itemName: [ :method | method gtDisplayString ]
]

{ #category : #spotter }
GtSpotterStart >> spotterForSendersFor: aStep [
	<spotterOrder: 31>

	aStep listProcessor
		title: 'Senders';
		filter: GTNullFilter item: [ :filter :context | 
			SystemNavigation default
				allSendersToString: context textTrimmed 
				do: filter ];
		keyBinding: $n meta;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> spotterImplementorsFor: aStep [
	<spotterOrder: 30>
	self flag: #specialFilter.
	aStep listProcessor
		title: 'Implementors';
		filter: GTFilterImplementor item: [ :filter :context | 
			SystemNavigation default allBehaviorsDo: [ :class | class localMethods do: filter ] ];
		keyBinding: $m meta;
		wantsToDisplayOnEmptyQuery: false
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
