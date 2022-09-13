Class {
	#name : #GtStreamingSpotterHeaderElement,
	#superclass : #BrVerticalPane,
	#traits : 'TGtStreamingWithSpotter',
	#classTraits : 'TGtStreamingWithSpotter classTrait',
	#instVars : [
		'searchField',
		'breadcrumb',
		'debugToolbar',
		'debugButton'
	],
	#category : #'GToolkit-Spotter-Streaming-UI'
}

{ #category : #initialization }
GtStreamingSpotterHeaderElement >> initialize [
	super initialize.

	self hMatchParent.
	self vFitContent.

	breadcrumb := GtStreamingSpotterBreadcrumb new.
	breadcrumb background: self theme header secondaryBackgroundColor.
	breadcrumb padding: (BlInsets left: 2).

	searchField := GtStreamingSpotterSearchField new.
	searchField
		vFitContent;
		hMatchParent;
		padding: (BlInsets all: 10);
		margin: (BlInsets left: 2).

	debugButton := BrButton new
		aptitude: BrGlamorousButtonWithIconCircularAptitude
			- BrGlamorousButtonExteriorAptitude
			+ BrGlamorousButtonFlatExteriorAptitude;
		icon: BrGlamorousVectorIcons driller ;
		label: 'Drill into Spotter';
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignCenter ];
		when: BlMouseDownEvent do: [ :anEvent |
			GtInspector openOn: spotter from: anEvent currentTarget ].

	self addChildren: {
		BrFrame new
			hMatchParent;
			vFitContent;
			addChildren: { breadcrumb . debugButton }.
		searchField.
		(BlElement new
			constraintsDo: [ :c | 
				c horizontal matchParent.
				c vertical exact: 1 ];
			background: self theme header secondaryBackgroundColor).
	}
]

{ #category : #'api - spotter' }
GtStreamingSpotterHeaderElement >> onDebugModeChanged [
	spotter isDebugMode
		ifTrue: [ debugButton visibility: BlVisibility visible ]
		ifFalse: [ debugButton visibility: BlVisibility gone ]
]

{ #category : #'api - spotter' }
GtStreamingSpotterHeaderElement >> onSpotterChanged [
	"Is sent when a new spotter is assigned to the receiver.
	Note: #onSpotterChanged is sent before #subscribeToSpotter
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSpotterChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	searchField spotter: spotter.
	breadcrumb spotter: spotter.
	self onDebugModeChanged
]

{ #category : #accessing }
GtStreamingSpotterHeaderElement >> searchField [
	^ searchField
]

{ #category : #'api - spotter' }
GtStreamingSpotterHeaderElement >> subscribeToSpotter [
	"Is sent after a new spotter is assigned to the receiver.
	It is required to unsubscribe from the previously subscribed objects by implementing
	#unsubscribeFromSpotter if the receiver subscribes to them"
	<modelSubscriber: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#subscribeToObjectTemplate'>
	
	spotter when: GtStreamingSpotterModeChanged send: #onDebugModeChanged to: self.
]

{ #category : #'api - spotter' }
GtStreamingSpotterHeaderElement >> unsubscribeFromSpotter [
	"Is sent before a new spotter is assigned to the receiver.
	Objects that subscribe to spotter are required to implement this method."
	<modelUnsubscriber: #spotter>
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#unsubscribeFromObjectTemplate'>
	
	spotter unsubscribe: self
]
