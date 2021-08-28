Class {
	#name : 'GtSelector',
	#superclass : 'Object',
	#instVars : [
		'name',
		'methods'
	],
	#category : 'GToolkit-Spotter-Utils'
}

{ #category : 'examples' }
GtSelector class >> gtExampleNew [
	<gtExample>
	^ self new name: #new
]

{ #category : 'private' }
GtSelector class >> substring: aString filter: aFilter [
	| selectors |
	aString isEmptyOrNil ifTrue: [ ^ self ].
	selectors := IdentityDictionary new.
	SystemNavigation default allBehaviorsDo: [ :class | 
		class selectorsAndMethodsDo: [ :selector :method | 
			(selector asString includesSubstring: aString caseSensitive: false) ifTrue: [ 
				| group newGroup | 
				group := selectors 
					at: selector 
					ifAbsentPut: [ aFilter value: (newGroup := GtSelector new name: selector; yourself). newGroup ].
				group addMethod: method ] ] ] 
]

{ #category : 'private accessing' }
GtSelector >> addMethod: aCompiledMethod [
	"this is a private method that can be used by the constructor on the class side
	exclusively within the context of Spotter"
	methods ifNil: [ methods := OrderedCollection new ].
	methods add: aCompiledMethod
]

{ #category : 'printing' }
GtSelector >> gtDisplayOn: stream [
	stream nextPutAll: self name
]

{ #category : 'accessing' }
GtSelector >> gtMethodsFor: aView [
	<gtView>
	methods ifNil: [ ^ aView empty ].
	^ aView columnedList
		title: 'Methods';
		priority: 1;
		items: [ methods ];
		column: 'Class' item: #methodClass;
		column: 'Method' item: #selector.
]

{ #category : 'gt-extensions' }
GtSelector >> gtSpotterImplementorsFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 40;
		title: 'Implementors';
		filter: GtFilterSubstring
			item: [ :filter :context | self implementors do: filter ];
		keyBinding: $m meta
]

{ #category : 'gt-extensions' }
GtSelector >> gtSpotterUsersFor: aStep [
	<gtSearch>
	^ aStep listProcessor
		priority: 50;
		title: 'Senders';
		filter: GtFilterSubstring
			item:
				[ :filter :context | self senders do: [ :sender | filter value: sender compiledMethod ] ];
		keyBinding: $n meta
]

{ #category : 'querying' }
GtSelector >> implementors [
	^ methods ifNil: [ 
		methods := (SystemNavigation default allImplementorsOf: self name) 
			collect: [ :each | each compiledMethod ] ]
]

{ #category : 'accessing' }
GtSelector >> name [
	^ name
]

{ #category : 'accessing' }
GtSelector >> name: anObject [
	name := anObject
]

{ #category : 'querying' }
GtSelector >> senders [
	^ SystemNavigation default allSendersOf: self name
]

{ #category : 'ui' }
GtSelector >> spotterImplementorsFor: aStep [
	<spotterOrder: 40>
	^ aStep listProcessor
		title: 'Implementors';
		filter: GtFilterSubstring item: [ :filter :context | self implementors do: filter ];
		keyBinding: $m meta
]

{ #category : 'ui' }
GtSelector >> spotterUsersFor: aStep [
	<spotterOrder: 50>
	^ aStep listProcessor
		title: 'Senders';
		filter: GtFilterSubstring item: [ :filter :context | 
			self senders do: [ :sender | 
				filter value: sender compiledMethod ] ];
		keyBinding: $n meta
]
