Class {
	#name : 'GtSpotterModelExamples',
	#superclass : 'Object',
	#category : 'GToolkit-Spotter-Examples'
}

{ #category : 'examples - basic' }
GtSpotterModelExamples class >> gtExampleBasic [
	<gtExample>
	<label: 'Basic Spotter object'>
	^ GTSpotter new
]

{ #category : 'examples - filtering' }
GtSpotterModelExamples class >> gtExampleCustomImplementorsSearchOn: aSpotter [
	<gtExample>
	<label: 'Custom implementors search'>
	<description: 'A spotter for searching through the implementors of a 
	method that overrides properties of the search step.'>
	<dependsOn: #gtExampleOnCompliedMethod>
	
	^ aSpotter
		processorsFilter: (GTSpotterMethodListProcessorFilter new 
			allowProcessorsFrom: CompiledMethod>>#spotterForImplementorsFor: 
			configuredWith: [ :aProcessor | aProcessor
				actLogic: [ :aMethod :step | 
					step exit.
					aMethod inform: aMethod name ];
				candidatesLimit: 50 ])
]

{ #category : 'examples - filtering' }
GtSpotterModelExamples class >> gtExampleCustomImplementorsSearchWithNavigationOn: aSpotter [
	<gtExample>
	<label: 'Custom implementors search with navigation'>
	<description: 'A spotter for searching through the implementors of a method that 
	overrides properties of the search step and enables the Collection 
	processor for items (to allow dive in).'>
	<dependsOn: #gtExampleOnCompliedMethod>
	
	^ aSpotter
		processorsFilter: (GTSpotterMethodListProcessorFilter new 
			allowProcessorsFrom: Collection>>#spotterItemsFor:;
			allowProcessorsFrom: CompiledMethod>>#spotterForImplementorsFor: 
			configuredWith: [ :aProcessor | aProcessor
				actLogic: [ :aMethod :step | 
					step exit.
					aMethod inform: aMethod name ];
				candidatesLimit: 50 ])
]

{ #category : 'examples - filtering' }
GtSpotterModelExamples class >> gtExampleHelpSearchOn: aSpotter [
	<gtExample>
	<label: 'Help search'>
	<description: 'A spotter for searching through help pages.'>
	<dependsOn: #gtExampleBasic>
	
	^ aSpotter
		filterByMethods: {
			GTSpotter>>#spotterForHelpTopicFor:.
			HelpTopic>>#spotterForHelpTopicFor:}
]

{ #category : 'examples - filtering' }
GtSpotterModelExamples class >> gtExampleImplementorsSearchOn: aSpotter [
	<gtExample>
	<label: 'Implementors search on single method'>
	<description: 'A spotter for searching through the implementors of a method.'>
	<dependsOn: #gtExampleOnCompliedMethod>
	
	^ aSpotter
		filterByMethods: {
			CompiledMethod>>#spotterForImplementorsFor:}
]

{ #category : 'examples - basic' }
GtSpotterModelExamples class >> gtExampleOnCompliedMethod [
	<gtExample>
	<label: 'Spotter on compiled method'>
	^ GTSpotter on: Object>>#copy
]

{ #category : 'examples - basic' }
GtSpotterModelExamples class >> gtExampleWithOneStepFrom: aSpotter [
	<gtExample>
	<label: 'Spotter object with one step'>
	<dependsOn: #gtExampleBasic>
	| step |
	step := GTSpotterStep new spotter: aSpotter.
	aSpotter steps add: step.
	aSpotter currentStep: step.
	^ aSpotter
]

{ #category : 'examples - filtering' }
GtSpotterModelExamples class >> gtExampleWorldMenuSearchOn: aSpotter [
	<gtExample>
	<label: 'World menu search'>
	<description: 'A spotter for searching through the world menu'>
	<dependsOn: #gtExampleBasic>

	^ aSpotter
		filterByMethods: {
			GTSpotter>>#spotterWorldMenuFor:}
	
	
]
