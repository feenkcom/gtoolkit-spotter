Extension { #name : #Object }

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterActDefault [
	^ GtInspector openOn: self
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterActDefault: aStep [
	aStep exit.
	self gtSpotterActDefault
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterProcessorsFor: aSpotterStep [
	"This is a utility method that collects all extensions (processors) for the current object.
	By default, it simply looks for the #spotterOrder: pragma.
	The step can decice whether or not an extension should be enabled.
	The step can also configure each extension (e.g. override any property)"
	
	^ ((Pragma 
		allNamed: #gtSearch
		from: self class 
		to: Object)
			select: [:pragma | aSpotterStep processorsFilter shouldEnableProcessorsCreateBy: pragma method])
			do: [ :pragma ||currentSize|
				currentSize := aSpotterStep processors size.
				self gtSpotterProcessorsFor: aSpotterStep pragma: pragma.
				aSpotterStep "configure the new processors if required"
					configureProcessorsStartingAt: currentSize+1 
					with: (aSpotterStep processorsFilter configurationBlockForProcessorsCreatedBy: pragma method)]
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterProcessorsFor: aSpotterStep pragma: aPragma [
	" if there is a problem with the definition of one or more processors, let the other processors continue to work "

	[ | processorsSize addedProcessorsSize |
	"To allow nice arrangement of processor within UI we need to assign to
		each processor its spotter order. Because it is possible
		to define multiple (or none) processors using pragma
		we need to detect how many new processors were added"
	processorsSize := aSpotterStep processors size.
	self perform: aPragma methodSelector with: aSpotterStep.
	addedProcessorsSize := aSpotterStep processors size - processorsSize.
	"assign spotter order for newly added ones"
	(aSpotterStep processors last: addedProcessorsSize)]
		on: Error
		do: [ :exception | 
			aSpotterStep exceptionHandler
				handleException: exception
				do: [ ('[Spotter] Exception while collecting processors for <'
						, self class name , '>: ' , exception asString) logCr ] ]
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterRePropertiesFor: aStep [
	<gtSearch>
	ReSettings spotterPlugin
		ifFalse: [ ^ self ].
	aStep listProcessor
		priority: 0;
		title: 'Renraku Properties';
		items: [ self externalProperties asArray ];
		itemName: #title;
		itemIcon: #icon;
		filter: GTFilterSubstring
]
