Class {
	#name : #GtSpotterHeaderElement,
	#superclass : #BlElement,
	#instVars : [
		'spotterModel',
		'searchField',
		'breadcrumb'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #accessing }
GtSpotterHeaderElement >> createNewSpotterButton [
	| aContainer |
	aContainer := BrHorizontalPane new.
	aContainer
		hFitContent;
		vMatchParent;
		in: [ :anElement |
			GtStreamingSpotter isEnabledChoiceMade
				ifTrue: [ anElement visibility: BlVisibility gone ] ];
		background: BrGlamorousColors newsBackgroundColor;
		margin: (BlInsets top: 0 left: 0 bottom: 0 right: 0);
		padding: (BlInsets top: 10 left: 10 bottom: 10 right: 14);
		clipChildren: false;
		constraintsDo: [ :c |
			c ignoreByLayout.
			c ignored horizontal alignRight.
			c ignored vertical alignCenter ];
		addChildren: {
			BrButton new
				vMatchParent;
				aptitude: BrGlamorousButtonWithLabelAptitude;
				label: 'Try new Spotter';
				action: [ :aButton | 
					GtStreamingSpotter enable: true.
					spotterModel exit.
					aContainer removeFromParent.
				].
			BrButton new
				aptitude: BrGlamorousButtonWithIconCircularAptitude;
				icon: BrGlamorousVectorIcons close;
				margin: (BlInsets top: 2 left: 0 bottom: 0 right: 0);
				beTinySize;
				constraintsDo: [ :c |
					c ignoreByLayout.
					c ignored horizontal alignRight.
					c ignored vertical alignTop ];
				action: [
					GtStreamingSpotter enable: false.
					aContainer removeFromParent ]
		}.
		
	^ aContainer
]

{ #category : #initialization }
GtSpotterHeaderElement >> initialize [
	super initialize.
	self layout: BlLinearLayout vertical.
	self
		constraintsDo: [ :c | 
			c horizontal matchParent.
			c vertical fitContent ].
	breadcrumb := GtSpotterBreadcrumb new.
	breadcrumb background: self theme header secondaryBackgroundColor.
	searchField := GtSpotterSearchField new.
	searchField
		vFitContent;
		hMatchParent.
	searchField padding: (BlInsets all: 15).
	
	self
		addChildren:
			{
			BrHorizontalPane new
				addChildren: { breadcrumb. self createNewSpotterButton};
				hMatchParent;
				vFitContent;
				yourself.
			searchField.
			(BlElement new
				constraintsDo: [ :c | 
					c horizontal matchParent.
					c vertical exact: 1 ];
				background: self theme header secondaryBackgroundColor)}
]

{ #category : #accessing }
GtSpotterHeaderElement >> searchField [
	^ searchField
]

{ #category : #accessing }
GtSpotterHeaderElement >> spotterModel [
	^ spotterModel
]

{ #category : #accessing }
GtSpotterHeaderElement >> spotterModel: aSpotter [

	spotterModel := aSpotter.
	
	searchField spotterModel: aSpotter.
	breadcrumb spotterModel: aSpotter.
]
