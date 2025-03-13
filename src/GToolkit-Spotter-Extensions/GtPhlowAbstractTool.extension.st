Extension { #name : #GtPhlowAbstractTool }

{ #category : #'*GToolkit-Spotter-Extensions' }
GtPhlowAbstractTool >> gtSpotterActDefaultFrom: aSpotterElement [
	BlSpace new
		inPager: self;
		title: self name;
		icon: self icon;
		withSceneDriller;
		showFrom: aSpotterElement.
]
