"
An element that represents a spotter step {{gtClass:GtStreamingSpotterStep}} and shows a grouped list of search results.
It reacts to a change of {{gtMethod:GtStreamingSpotterStep>>#searchQuery:}} by subscribing to {{gtClass:GtStreamingSpotterStepSearchQueryChanged}}.
"
Class {
	#name : #GtStreamingSpotterStepElement,
	#superclass : #BrFrame,
	#traits : 'TGtStreamingWithSpotterStep',
	#classTraits : 'TGtStreamingWithSpotterStep classTrait',
	#instVars : [
		'resultsElement'
	],
	#category : #'GToolkit-Spotter-Streaming-UI'
}

{ #category : #initialization }
GtStreamingSpotterStepElement >> initialize [
	super initialize.
	
	self matchParent.
	
	resultsElement := BrGroupedList new.
	resultsElement
		matchParent;
		headerElementStencil: [
			BrLabel new
				hMatchParent;
				margin: (BlInsets top: 10);
				aptitude: (BrGlamorousLabelAptitude new foreground: Color gray) ];
		headerDataBinder: [ :aLabel :eachGroup |
			aLabel text: eachGroup domainObject title ].

	self addChild: resultsElement
]

{ #category : #'private - event handling' }
GtStreamingSpotterStepElement >> onSearchQueryChanged [
	| aGroupesStream |
	
	aGroupesStream := spotterStep createSearchResultsStream collect: [ :eachSearchAndResults |
		| aSearch aSearchStream |
		
		aSearch := eachSearchAndResults key.
		aSearchStream := eachSearchAndResults value.
		
		BrGroup new
			stream: aSearchStream;
			domainObject: aSearch;
			itemStencil: [
				BrLabel new
					hMatchParent;
					aptitude: BrGlamorousLabelAptitude + BrGlamorousListItemAptitude ];
			itemDataBinder: [ :aLabel :eachItem |
				aLabel text: eachItem asString ];
			itemsLimit: 5 ].

	resultsElement groupsProvider: aGroupesStream
]

{ #category : #'api - spotter step' }
GtStreamingSpotterStepElement >> onSpotterStepChanged [
	"Is sent when a new spotterStep is assigned to the receiver.
	Note: #onSpotterStepChanged is sent before #subscribeToSpotterStep
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSpotterStepChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	self onSearchQueryChanged
]

{ #category : #'api - spotter step' }
GtStreamingSpotterStepElement >> subscribeToSpotterStep [
	"Is sent after a new spotterStep is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSpotterStep if the receiver subscribes to them"
	<modelSubscriber: #spotterStep>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>

	spotterStep
		when: GtStreamingSpotterStepSearchQueryChanged
		send: #onSearchQueryChanged
		to: self
]

{ #category : #'api - spotter step' }
GtStreamingSpotterStepElement >> unsubscribeFromSpotterStep [
	"Is sent before a new spotterStep is assigned to the receiver.
	Objects that subscribe to spotterStep are required to implement this method."
	<modelUnsubscriber: #spotterStep>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	spotterStep unsubscribe: self
]
