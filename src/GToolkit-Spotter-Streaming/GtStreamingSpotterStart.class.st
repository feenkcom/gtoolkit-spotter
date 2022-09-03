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

{ #category : #printing }
GtStreamingSpotterStart >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Spotter'
]

{ #category : #accessing }
GtStreamingSpotterStart >> gtPackagesFor: aSearch [
	<gtSpotterSearch>
	
	^ GtSpotterCollectionSearch new
		title: 'Packages';
		priority: 6;
		items: [ RPackageOrganizer default packages ];
		filter: [ GtSpotterSubstringFilter new ]
]
