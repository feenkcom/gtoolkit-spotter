Class {
	#name : 'GtSpotterExtensionSettings',
	#superclass : 'Object',
	#classInstVars : [
		'disabledExtensions'
	],
	#category : 'GToolkit-Spotter-Model'
}

{ #category : 'settings' }
GtSpotterExtensionSettings class >> catalogSettingsOn: aBuilder [
	<systemsettings>
	(aBuilder group: #gtspotter)
		parent: #gt;
		label: 'GT Spotter extensions';
		description: 'All extensions of GT Spotter';
		with:
				[ 
				| extensions groupedExtensions sortedAssociations |
				extensions := GtSpotter spotterExtendingMethods.
				groupedExtensions := (extensions groupedBy: #methodClass) associations.
				sortedAssociations := groupedExtensions asSortedCollection: [ :a1 :a2 | a1 key name < a2 key name ].
				sortedAssociations do: [ :association |
					(aBuilder group: association key name)
						parent: #gtspotter;
						label: 'Extensions defined on ', association key name;
						description: 'All extensions of ', association key name;
						with: [ 
							association value do:
								[ :each | 
									(aBuilder setting: (self internalKeyForMethod: each))
										target: self;
										label: (self spotterExtensionTitleOf: each);
										description: each sourceCode;
										default: true ] ] ]
				]
				
]

{ #category : 'settings' }
GtSpotterExtensionSettings class >> disableProcessorDefinedInMethod: aMethod [
	self disabledExtensions add: (self internalKeyForMethod: aMethod)
]

{ #category : 'private' }
GtSpotterExtensionSettings class >> disabledExtensions [
	^ disabledExtensions ifNil: [ disabledExtensions := Set new ]
]

{ #category : 'private' }
GtSpotterExtensionSettings class >> doesNotUnderstand: aMessage [
	aMessage arguments isEmpty
		ifTrue: [ ^ (self disabledExtensions includes: aMessage selector) not ].
	aMessage arguments size = 1
		ifTrue: [ 
			^ aMessage arguments first
				ifTrue: [ self disabledExtensions 
						remove: aMessage selector allButLast 
						ifAbsent: [ "ignore all settings that are re-enabled but 
										that were not disabled before
										(it can happen when the property was renamed)" ] ]
				ifFalse: [ self disabledExtensions add: aMessage selector allButLast ] ].
	^ super doesNotUnderstand: aMessage
]

{ #category : 'settings' }
GtSpotterExtensionSettings class >> enableProcessorDefinedInMethod: aMethod [
	self disabledExtensions remove: (self internalKeyForMethod: aMethod)
]

{ #category : 'settings' }
GtSpotterExtensionSettings class >> groupedAndSortedSpotterExtensions [
	"Return a list of associations in which:
		the key is a class
		the value is the list of spotter extensions.
	The returned list is ordered according to the class name"

	| extensions groupedExtensions |
	extensions := GtSpotter spotterExtendingMethods.
	groupedExtensions := (extensions groupedBy: #methodClass) associations.
	^ groupedExtensions asSortedCollection: [ :a1 :a2 | a1 key name < a2 key name ]. 
]

{ #category : 'private' }
GtSpotterExtensionSettings class >> internalKeyForMethod: each [
	^ (each methodClass name , '_' , each selector allButLast) asSymbol
]

{ #category : 'settings' }
GtSpotterExtensionSettings class >> shouldSpotterIgnoreProcessorDefinedInMethod: aCompiledMethod [
	"
	Return a boolean value indicating if the spotter extension method, provided as argument, has to be disabled or not
	 
	self shouldSpotterIgnoreProcessorDefinedInMethod: (MCPackage>> #spotterForPackageFor:)
	"
	^ self disabledExtensions includes: aCompiledMethod methodClass name, '_', aCompiledMethod selector allButLast
]

{ #category : 'settings' }
GtSpotterExtensionSettings class >> spotterExtensionTitleOf: extensionAsCompiledMethod [
	"
	Return an approximation of a description of the extension provided as argument.
	The argument has to be a compiled method representing a Spotter extension
	
	The description is fetched from the argument passed to the list processor.
	For example:
	self spotterExtensionTitleOf: MCPackage>> #spotterForPackageFor: 
	"
	| title |
	title := extensionAsCompiledMethod ast allChildren 
		detect: [ :node | node isMessage and: [ node selector = #title: ] ]
		ifFound: [ :node | node arguments first value. ]
		ifNone: [ extensionAsCompiledMethod selector ].
	title isString ifFalse: [ title := extensionAsCompiledMethod selector ].
	^ title
]
