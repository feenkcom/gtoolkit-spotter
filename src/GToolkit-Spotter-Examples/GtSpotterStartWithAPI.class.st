Class {
	#name : #GtSpotterStartWithAPI,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Examples'
}

{ #category : #accessing }
GtSpotterStartWithAPI >> gtSpotterSearchWithAllAPI: aSearch [
	<gtSearch>
	^ aSearch list
		priority: 10;
		title: 'Search with preview object and preview element';
		items: [ #(10) ];
		itemName: [ :each | each asString ];
		send: [ :aRawObject :aStep :thisSearch | { aRawObject . aStep . thisSearch } ];
		sendTool: [ :anObjectToSend :aRawObject :aStep :thisSearch |
			GtInspectorTool forObject: { thisSearch . aStep . aRawObject . anObjectToSend } ];
		sendCategory: [ :aCategory :aStep :thisSearch |
			{ aCategory  . aStep . thisSearch } ];
		sendCategoryTool: [ :aCategoryToSend :aRawCategory :aStep :thisSearch |
			GtInspectorTool forObject: { thisSearch . aStep . aRawCategory. aCategoryToSend } ];
		previewObject: [ :x | x even ];
		previewElement: [ :aBoolean | (aBoolean gtLiveFor: GtPhlowEmptyView new) asElement ];
		filterBySubstring;
		wantsToDisplayOnEmptyQuery: true
]
