Class {
	#name : #GtSpotterHeaderElement,
	#superclass : #BlElement,
	#instVars : [
		'spotterModel',
		'searchField',
		'breadcrumb'
	],
	#category : 'GToolkit-Spotter-UI'
}

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
			{breadcrumb.
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
