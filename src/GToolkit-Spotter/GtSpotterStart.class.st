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

{ #category : #accessing }
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

{ #category : #searches }
GtSpotterStart >> gtSearchForClassesFor: aSearch [
	<gtSpotterSearch>
	
	^ aSearch explicit
		priority: 10;
		title: 'Classes';
		search: [ :aContext | GtPharoIndex current asyncClassNamesForWord: aContext searchQuery ]
]

{ #category : #searches }
GtSpotterStart >> gtSearchForPragmasFor: aSearch [
	<gtSpotterSearch>

	^ aSearch list
		priority: 40;
		items: [ GtPragmaType all ];
		title: 'Pragmas';
		itemName: [ :pragma | pragma keyword ];
		filter: GtSpotterSubstringFilter new;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #searches }
GtSpotterStart >> gtSearchImplementorsFor: aSearch [
	<gtSpotterSearch>

	^ aSearch explicit
		priority: 30;
		title: 'Implementors';
		search: [ :aContext | GtPharoIndex current asyncImplementersForWord: aContext searchQuery ]
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterClipboardFor: aStep [
	"<gtSearch>"
	aStep listProcessor
		priority: 90;
		title: 'Clipboard History';
		items: [ Clipboard default recentItems ];
		itemName: [ :item | item asString contractTo: 100 ];
		itemFilterName: [ :item | item asString ];
		filter: GtFilterSubstrings;
		actLogic: [ :item :step | 
			step exit.
			item asString inspect ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterConcreteMethodFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 30;
		title: 'Methods';
		filter: GtNullFilter
			item:
				[ :filter :context | self concreteMethodsInContext: context usingFilter: filter ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForAllSubclassesFor: aStep [
	"<gtSearch>"
	aStep listProcessor
		priority: 52;
		filter: GtNullFilter
			item: [ :filter :context | 
				Smalltalk 
					at: context textTrimmed asSymbol 
					ifPresent: [:class | 
						class withAllSubclasses do: [:c |
							filter value: c ] ] ];
		title: 'All Subclasses';
		itemIcon: #systemIcon;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForAllSuperclassesFor: aStep [
	"<gtSearch>"
	aStep listProcessor
		priority: 51;
		filter: GtNullFilter
			item: [ :filter :context | 
				Smalltalk 
					at: context textTrimmed asSymbol 
					ifPresent: [:class | 
						class withAllSuperclasses do: [:c |
							filter value: c ] ] ];
		title: 'All Superclasses';
		itemIcon: #systemIcon;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForClassesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 10;
		items: [ Smalltalk allClassesAndTraits ];
		title: 'Classes';
		filter: GtFilterSubstring;
		itemIcon: #systemIcon;
		keyBinding: $b meta;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForDirectoriesFor: aStep [
	"<gtSearch>"
	self flag: #specialFilter.
	aStep listProcessor
		priority: 50;
		title: 'Directories';
		itemIcon: [ BrGlamorousIcons folder ];
		itemFilterName: [ :reference | reference basename ];
		filter: GtFilterFileReference
			item: [ :filter :context | 
			self
				fileReferencesBy: #directories
				inContext: context
				usingFilter: filter ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForFilesFor: aStep [
	"<gtSearch>"
	self flag: #specialFilter.
	aStep listProcessor
		priority: 40;
		title: 'Files';
		itemIcon: [ BrGlamorousIcons file ];
		itemFilterName: [ :reference | reference basename ];
		filter: GtFilterFileReference
			item:
				[ :filter :context | self fileReferencesBy: #files inContext: context usingFilter: filter ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForGlobalVarsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 40;
		allCandidates: [ Smalltalk globals associations
				select:
					[ :assoc | assoc value isBehavior not and: [ assoc value isTrait not ] ] ];
		title: 'Global variables';
		itemName: [ :global | global key ];
		filter: GtFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForIcebergRepositoriesFor: aStep [
	<gtSearch>
	
	aStep listProcessor
		priority: 88;
		title: 'Iceberg Repositories';
		allCandidates: [ IceRepository registry ];
		itemName: [ :aRepository | aRepository name ];
		wantsToDisplayOnEmptyQuery: false;
		filter: GtFilterSubstring;
		actLogic: [ :anIcebergRepository :step :spotterElement | 
			anIcebergRepository
				gtSpotterActDefault: step 
				from: spotterElement ]
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForMessagesFor: aStep [
	"<gtSearch>"
	aStep listProcessor
		priority: 35;
		title: 'Messages';
		filter: GtNullFilter
			item: [ :filter :context | 
				GtSelector substring: context textTrimmed filter: filter ];
		actLogic: [ :each :step :spotterElement | 
			(each name asSymbol gtImplementors)
				gtSpotterActDefault: step
				from: spotterElement ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForMetacelloBaselinesFor: aStep [
	"<gtSearch>"
	aStep listProcessor
		priority: 86;
		title: 'Metacello baselines';
		allCandidates: [ BaselineOf allSubclasses ];
		itemName: [ :each | each name ];
		filter: GtFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForPackagesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 20;
		allCandidates: [ RPackageOrganizer default packages ];
		title: 'Packages';
		itemName: [ :package | package name ];
		itemIcon: [ Smalltalk ui icons iconNamed: #packageIcon ];
		filter: GtFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForPragmasFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 40;
		allCandidates: [ GtPragmaType all ];
		title: 'Pragmas';
		itemName: [ :pragma | pragma keyword ];
		filter: GtFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForReferencesFor: aStep [
	"<gtSearch>"
	
	aStep listProcessor
		priority: 32;
		title: 'References';
		filter: GtNullFilter
			item: [ :filter :context | 
				self class environment
					at: context textTrimmed asSymbol
					ifPresent: [ :class | 
						| binding |
						binding := class binding.
						(binding isKindOf: GlobalVariable)
							ifTrue: [ (GtPharoIndex current globalVariableReferencesTo: binding) do: filter ]
							ifFalse: [ SystemNavigation default allReferencesTo: binding do: filter ] ] ];
		keyBinding: $n shift meta;
		itemName: [ :method | method gtDisplayString ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForResourcesUtilityFromPathFor: aStep [
	"<gtSearch>"
	^ (GtResourcesUtility default spotterForPathResourcesFor: aStep)
		priority: 40;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForResourcesUtilityFromStringFor: aStep [
	"<gtSearch>"
	^ aStep listProcessor
		title: 'Resource from file or directory name';
		priority: 2;
		itemName: #basename;
		wantsToDisplayOnEmptyQuery: false;
		filter: GtNullFilter item: [ :aFilter :aContext | 
			| aFile |
			aContext textTrimmed ifNotEmpty: [ :aText |
				aFile := GtResourcesUtility default resourceAtPath: aContext textTrimmed.
				aFile exists ifTrue: [ aFilter value: aFile ] ] ]
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForSendersFor: aStep [
	"<gtSearch>"
	
	aStep listProcessor
		priority: 31;
		title: 'Senders';
		filter: GtNullFilter
			item: [ :filter :context | 
				| search |
				search := context textTrimmed.
				search numArgs >= 0
					ifTrue: [ (GtPharoIndex current sendersOf: search) do: filter ]
					ifFalse: [ SystemNavigation default allReferencesTo: search do: filter ] ];
		keyBinding: $n meta;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterImplementorsFor: aStep [
	<gtSearch>
	self flag: #specialFilter.
	aStep listProcessor
		priority: 30;
		title: 'Implementors';
		filter: GtFilterImplementor
			item: [ :filter :context | 
			SystemNavigation default
				allBehaviorsDo: [ :class | class localMethods do: filter ] ];
		keyBinding: $m meta;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> spotterForPixelIconFor: aStep [
	"<gtSearch>"
	^ aStep listProcessor
		title: 'Icon - Pixeled';
		priority: 101;
		allCandidates: [ GtSpotterPixelIconPreview 
			library: BrGlamorousIcons allForms: BrGlamorousIcons allIcons ];
		itemName: #iconSelector;
		filter: GtFilterSubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> spotterForVectorIconFor: aStep [
	"<gtSearch>"
	^ aStep listProcessor
		title: 'Icons - Vectorized';
		priority: 100;
		allCandidates: [ GtSpotterVectorIconPreview 
			library: BrGlamorousVectorIcons allIcons: BrGlamorousVectorIcons allIcons ];
		itemName: #iconSelector;
		filter: GtFilterSubstring;
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
