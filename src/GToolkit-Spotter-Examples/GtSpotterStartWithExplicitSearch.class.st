Class {
	#name : #GtSpotterStartWithExplicitSearch,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples-Exceptions'
}

{ #category : #'as yet unclassified' }
GtSpotterStartWithExplicitSearch >> gtSearchFor: aSearch [
	<gtSearch>
	
	^ aSearch explicit
		title: 'Explicit search';
		priority: 1;
		search: [ :aContext | 1 to: 3 ];
		itemName: [ :each | '+', each asString ];
		itemActLogic: [ Halt now ];
		wantsToDisplayOnEmptyQuery: true
]
