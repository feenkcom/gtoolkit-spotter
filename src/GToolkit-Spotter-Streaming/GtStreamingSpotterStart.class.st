Class {
	#name : #GtStreamingSpotterStart,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Streaming-Model'
}

{ #category : #accessing }
GtStreamingSpotterStart >> gtClassesFor: aSearch [
	<gtSpotterSearch>
	
	^ GtSpotterCollectionSearch new
		title: 'Classes';
		priority: 5;
		items: [ AsyncImageBehaviorsStream new ];
		filter: [ GtSpotterSubstringFilter new ]
]
