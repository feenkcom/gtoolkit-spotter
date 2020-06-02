"
I collect Spotter search pragmas.
Each pragma is a Spotter extension for a given ${method:GtSpotterProcessorsCollector>>#object|label=#selector}$.
By default, I look for ${example:GtSpotterProcessorsCollector>>#defaultPragmaSymbol|label=#yourself}$ pragmas. It can be changed by ${method:GtSpotterProcessorsCollector>>#pragmaName:|label=#selector}$.
The ${method:GtSpotterProcessorsCollector>>#spotterStep|label=#selector}$ can decide whether or not an extension is enabled.
It can also configure each extension, e.g., override any property.

I am used by ${class:GtSpotterStep}$.
"
Class {
	#name : #GtSpotterProcessorsCollector,
	#superclass : #Object,
	#instVars : [
		'spotterStep',
		'object',
		'from',
		'to',
		'pragmaName'
	],
	#category : #'GToolkit-Spotter-Collectors'
}

{ #category : #'api - collect' }
GtSpotterProcessorsCollector >> collect [
	<return: #Collection of: #Pragma>

	^ self selectPragmas do: [ :pragma | 
		self doPragma: pragma ]
]

{ #category : #'api - collect' }
GtSpotterProcessorsCollector >> collectPragmas [
	<return: #Collection of: #Pragma>
	^ Pragma allNamed: self pragmaName from: self from to: self to
]

{ #category : #defaults }
GtSpotterProcessorsCollector >> defaultFromClass [
	^ nil class
]

{ #category : #defaults }
GtSpotterProcessorsCollector >> defaultPragmaSymbol [
	<gtExample>
	^ #gtSearch
]

{ #category : #defaults }
GtSpotterProcessorsCollector >> defaultToClass [
	^ Object
]

{ #category : #enumerating }
GtSpotterProcessorsCollector >> definingMethodFor: aPragma [
	<return: #CompiledMethod>
	^ aPragma method
]

{ #category : #enumerating }
GtSpotterProcessorsCollector >> doPragma: pragma [
	| currentSize |
	currentSize := self spotterStep processors size.
	self processorsForPragma: pragma.
	^ self spotterStep
		configureProcessorsStartingAt: currentSize + 1
		with:
			(self spotterStep processorsFilter
				configurationBlockForProcessorsCreatedBy: pragma method)
]

{ #category : #'api - accessing' }
GtSpotterProcessorsCollector >> exceptionHandler [
	^ self spotterStep exceptionHandler
]

{ #category : #'api - accessing' }
GtSpotterProcessorsCollector >> from [
	^ from
]

{ #category : #'api - accessing' }
GtSpotterProcessorsCollector >> from: anObject [
	from := anObject
]

{ #category : #'api - initialization' }
GtSpotterProcessorsCollector >> fromObject: anObject [
	self object: anObject.
	self from: anObject class.
]

{ #category : #initialization }
GtSpotterProcessorsCollector >> initialize [
	super initialize.
	pragmaName := self defaultPragmaSymbol.
	from := self defaultFromClass.
	to := self defaultToClass
]

{ #category : #'api - accessing' }
GtSpotterProcessorsCollector >> object [
	^ object
]

{ #category : #'api - accessing' }
GtSpotterProcessorsCollector >> object: anObject [
	object := anObject
]

{ #category : #'api - accessing' }
GtSpotterProcessorsCollector >> pragmaName [
	^ pragmaName
]

{ #category : #'api - accessing' }
GtSpotterProcessorsCollector >> pragmaName: anObject [
	pragmaName := anObject
]

{ #category : #enumerating }
GtSpotterProcessorsCollector >> processorsForPragma: aPragma [
	"if there is a problem with the definition of one or more processors, 
	let the other processors continue to work"

	[ 
		| aProcessor |
		aProcessor := self object perform: aPragma methodSelector with: self spotterStep.
		(aProcessor respondsTo: #definingMethod:) ifTrue: [ 
			aProcessor definingMethod: (self definingMethodFor: aPragma) ]
	]	on: Error
		do: [ :anException | 
			self exceptionHandler
				handleException: anException
				do: [ ('[Spotter] Exception while collecting processors for <'
						, self object className , '>>#', aPragma methodSelector, '>: ' , anException asString) traceCr ] ]
]

{ #category : #'api - collect' }
GtSpotterProcessorsCollector >> selectPragmas [
	<return: #Collection of: #Pragma>
	^ self collectPragmas
		select: [ :eachPragma | 
			self shouldEnableProcessorsCreateBy: eachPragma ]
]

{ #category : #testing }
GtSpotterProcessorsCollector >> shouldEnableProcessorsCreateBy: aPragma [
	<return: #Boolean>
	^ self spotterStep processorsFilter
			shouldEnableProcessorsCreateBy: aPragma method
]

{ #category : #'api - accessing' }
GtSpotterProcessorsCollector >> spotterStep [
	^ spotterStep
]

{ #category : #'api - accessing' }
GtSpotterProcessorsCollector >> spotterStep: anObject [
	spotterStep := anObject
]

{ #category : #'api - accessing' }
GtSpotterProcessorsCollector >> to [
	^ to
]

{ #category : #'api - accessing' }
GtSpotterProcessorsCollector >> to: anObject [
	to := anObject
]
