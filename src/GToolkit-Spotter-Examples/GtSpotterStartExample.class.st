Class {
	#name : #GtSpotterStartExample,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples'
}

{ #category : #'as yet unclassified' }
GtSpotterStartExample >> gtSpotterSearch_10: aStep [
	<gtSearch>

	aStep listProcessor
		priority: 10;
		title: 'Priority 10';
		allCandidates: [ #(10) ];
		itemName: [ :each | each asString ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'as yet unclassified' }
GtSpotterStartExample >> gtSpotterSearch_20: aStep [
	<gtSearch>

	aStep listProcessor
		priority: 20;
		title: 'Priority 20';
		allCandidates: [ #(20 20) ];
		itemName: [ :each | each asString ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'as yet unclassified' }
GtSpotterStartExample >> gtSpotterSearch_30: aStep [
	<gtSearch>

	aStep listProcessor
		priority: 30;
		title: 'Priority 30';
		allCandidates: [ #(30 30 30) ];
		itemName: [ :each | each asString ];
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
