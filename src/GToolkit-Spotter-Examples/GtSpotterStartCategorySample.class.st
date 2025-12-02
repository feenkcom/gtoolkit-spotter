Class {
	#name : #GtSpotterStartCategorySample,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #'as yet unclassified' }
GtSpotterStartCategorySample >> gtSpotterSearchWithSendCategory: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 10;
		title: 'Send category items';
		items: [ self items ];
		itemName: [ :each | 'Number {1}' format: { each asString } ];
		send: [ :aRawObject :aStep :thisSearch | { aRawObject . aStep . thisSearch } ];
		sendTool: [ :anObjectToSend :aRawObject :aStep :thisSearch |
			GtInspectorTool forObject: { thisSearch . aStep . aRawObject . anObjectToSend } ];
		sendCategory: [ :aCategory :aStep :thisSearch |
			GtSpotterStartCategorySample new items: aCategory items ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #'as yet unclassified' }
GtSpotterStartCategorySample >> gtSpotterSearchWithSendCategoryTool: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 20;
		title: 'Send category tool items';
		items: [ self items ];
		itemName: [ :each | 'Number {1}' format: { each asString } ];
		send: [ :aRawObject :aStep :thisSearch | { aRawObject . aStep . thisSearch } ];
		sendTool: [ :anObjectToSend :aRawObject :aStep :thisSearch |
			GtInspectorTool forObject: { thisSearch . aStep . aRawObject . anObjectToSend } ];
		sendCategoryTool: [ :aCategoryToSend :aRawCategory :aStep :thisSearch |
			GtInspectorTool forObject: (GtSpotterStartCategorySample new items: aCategoryToSend items) ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]

{ #category : #accessing }
GtSpotterStartCategorySample >> items [
	^ items ifNil: [ items := 0 to: 100 ]
]

{ #category : #accessing }
GtSpotterStartCategorySample >> items: aCollection [
	items := aCollection
]
