Class {
	#name : #GtSpotterStart,
	#superclass : #Object,
	#instVars : [
		'spotterModel'
	],
	#category : #'GToolkit-Spotter-Extensions'
}

{ #category : #accessing }
GtSpotterStart >> concreteMethodInContext: aContext [
	" return the concrete methods described by the expression (Class >> #Selector) - evaluate it safely"
	<return: #AsyncOptionalValue>
	| classAndSelectorStrings class selector |

	classAndSelectorStrings := (aContext searchQuery trimBoth splitOn: '>>')
		collect: [ :each | each trimBoth ].
	
	" Jenkins reports include `Object.method` strings."
	classAndSelectorStrings size = 2 ifFalse: [
		classAndSelectorStrings := (aContext searchQuery trimBoth splitOn: '.')
			collect: [ :each | each trimBoth ] ].
	
	" check preconditions "
	classAndSelectorStrings size = 2
		ifFalse: [ ^ AsyncOptionalValue none  ].
	classAndSelectorStrings second size < 2
		ifTrue: [ ^ AsyncOptionalValue none ].

	" retrieve concrete class and selector - or search all behaviors "
	selector := classAndSelectorStrings second first = $# 
		ifTrue: [ classAndSelectorStrings second allButFirst asSymbol ]
		ifFalse: [ classAndSelectorStrings second asSymbol ].
	
	(class := Smalltalk classNamed: classAndSelectorStrings first)
		ifNil: [ ^ AsyncOptionalValue none ].

	^ [ AsyncOptionalValue some: (class compiledMethodAt: selector) ]
		on: Error
		do: [ AsyncOptionalValue none ].
]

{ #category : #accessing }
GtSpotterStart >> fileReferencesBy: aSelector inContext: aSpotterContext [
	^ ((aSpotterContext searchQuery asAsyncFuture asAsyncStream collect: #trimBoth)
		collect: [ :aQuery | 
			| lastDelimiter |
			lastDelimiter := aQuery
					findLastOccurrenceOfString: FileSystem disk delimiter asString
					startingAt: 1.

			lastDelimiter isZero
				ifTrue: [ AsyncEmptyStream new ]
				ifFalse: [ | rootDirectory allItems |
					rootDirectory := (aQuery copyFrom: 1 to: lastDelimiter) asFileReference.
					rootDirectory exists 
						ifFalse: [ AsyncEmptyStream new ]
						ifTrue: [
							allItems := (rootDirectory perform: aSelector) asAsyncStream.
							lastDelimiter = aQuery size
								ifTrue: [ allItems ]
								ifFalse: [ (GtSpotterSubstringFilterStream
										forStream: allItems
										search: (aQuery copyFrom: lastDelimiter + 1 to: aQuery size))
										itemString: [ :eachFile | eachFile basename ] ] ] ] ]) flatten
]

{ #category : #printing }
GtSpotterStart >> gtDisplayOn: stream [
	stream nextPutAll: 'Spotter'
]

{ #category : #spotter }
GtSpotterStart >> gtSearchConcreteMethodFor: aSearch [
	<gtSearch>

	^ aSearch explicit
		priority: 5;
		title: 'Method';
		search: [ :aContext |
			AsyncMaybeOnceStream forFuture:
				[ self concreteMethodInContext: aContext ] asAsyncFuture ]
]

{ #category : #searches }
GtSpotterStart >> gtSearchForClassesFor: aSearch [
	<gtSearch>
	
	^ aSearch explicit
		priority: 10;
		title: 'Classes';
		search: [ :aContext | GtPharoIndex current asyncClassesForWord: aContext searchQuery ];
		"itemIcon: #systemIcon;"
		"keyBinding: $b meta;"
		yourself
]

{ #category : #searches }
GtSpotterStart >> gtSearchForGlobalVarsFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 40;
		items: [ Smalltalk globals associations
				select: [ :assoc | assoc value isBehavior not and: [ assoc value isTrait not ] ] ];
		title: 'Global variables';
		itemName: [ :global | global key ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSearchForIcebergRepositoriesFor: aSearch [
	<gtSearch>

	^ aSearch list
		priority: 88;
		title: 'Iceberg Repositories';
		items: [ IceRepository registry ];
		itemName: [ :aRepository | aRepository name ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #searches }
GtSpotterStart >> gtSearchForPackagesFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'Packages';
		priority: 20;
		items: [ RPackageOrganizer default packages ];
		itemName: [ :aPackage | aPackage name ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: false	"itemIcon: [ Smalltalk ui icons iconNamed: #packageIcon ];"
]

{ #category : #searches }
GtSpotterStart >> gtSearchForPragmasFor: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 40;
		items: [ GtPragmaType all ];
		title: 'Pragmas';
		itemName: [ :pragma | pragma keyword ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #searches }
GtSpotterStart >> gtSearchImplementorsFor: aSearch [
	<gtSearch>

	^ aSearch explicit
		priority: 30;
		title: 'Implementors';
		search: [ :aContext | GtPharoIndex current asyncImplementersForWord: aContext searchQuery ];
		"keyBinding: $m meta;"
		yourself
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterClipboardFor: aSearch [
	<gtSearch>
	
	^ aSearch list
		priority: 90;
		title: 'Clipboard History';
		items: [ Clipboard default recentItems ];
		itemName: [ :item | item asString contractTo: 100 ];
		filterBySubstring;
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
GtSpotterStart >> gtSpotterForDirectoriesFor: aSearch [
	<gtSearch>
	
	^ aSearch explicit
		priority: 0;
		title: 'Directories';
		"itemIcon: [ BrGlamorousIcons folder ];"
		search: [ :aContext | self fileReferencesBy: #directories inContext: aContext ]
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForFilesFor: aSearch [
	<gtSearch>
	
	^ aSearch explicit
		priority: 1;
		title: 'Files';
		"itemIcon: [ BrGlamorousIcons file ];"
		search: [ :aContext | self fileReferencesBy: #files inContext: aContext ]
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
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #spotter }
GtSpotterStart >> gtSpotterForPixelIconFor: aStep [
	"<gtSearch>"
	^ aStep listProcessor
		title: 'Icon - Pixeled';
		priority: 101;
		allCandidates: [ GtSpotterPixelIconPreview 
			library: BrGlamorousIcons allForms: BrGlamorousIcons allIcons ];
		itemName: #iconSelector;
		filterBySubstring;
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
GtSpotterStart >> gtSpotterForVectorIconFor: aStep [
	"<gtSearch>"
	^ aStep listProcessor
		title: 'Icons - Vectorized';
		priority: 100;
		allCandidates: [ GtSpotterVectorIconPreview 
			library: BrGlamorousVectorIcons allIcons: BrGlamorousVectorIcons allIcons ];
		itemName: #iconSelector;
		filterBySubstring;
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
