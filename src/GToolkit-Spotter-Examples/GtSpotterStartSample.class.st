Class {
	#name : #GtSpotterStartSample,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples'
}

{ #category : #'spotter-extensions' }
GtSpotterStartSample >> gtSpotterSearch_10: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 10;
		title: 'Priority 10';
		items: [ #(10) ];
		itemName: [ :each | each asString ];
		send: [ :aRawObject :aStep :thisSearch | { aRawObject . aStep . thisSearch } ];
		sendTool: [ :anObjectToSend :aRawObject :aStep :thisSearch |
			GtInspectorTool forObject: { thisSearch . aStep . aRawObject . anObjectToSend } ];
		sendCategory: [ :aCategory :aStep :thisSearch |
			{ aCategory  . aStep . thisSearch } ];
		sendCategoryTool: [ :aCategoryToSend :aRawCategory :aStep :thisSearch |
			GtInspectorTool forObject: { thisSearch . aStep . aRawCategory. aCategoryToSend } ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'spotter-extensions' }
GtSpotterStartSample >> gtSpotterSearch_20: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 20;
		title: 'Priority 20';
		items: [ #(20 20) ];
		itemName: [ :each | each asString ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'spotter-extensions' }
GtSpotterStartSample >> gtSpotterSearch_30: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 30;
		title: 'Priority 30';
		items: [ #(30 30 30) ];
		itemName: [ :each | each asString ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]
