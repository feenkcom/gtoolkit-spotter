Class {
	#name : #GtStreamingSpotterStart,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Streaming-Model'
}

{ #category : #searches }
GtStreamingSpotterStart >> gtClassesFor: aSearch [
	<gtSpotterSearch>
	
	^ aSearch list
		title: 'Classes';
		priority: 10;
		items: [ AsyncImageBehaviorsStream new ];
		filter: [ GtSpotterSubstringFilter new ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #printing }
GtStreamingSpotterStart >> gtDisplayOn: aStream [
	aStream nextPutAll: 'Spotter'
]

{ #category : #searches }
GtStreamingSpotterStart >> gtPackagesFor: aSearch [
	<gtSpotterSearch>
	
	^ aSearch list
		title: 'Packages';
		priority: 20;
		items: [ RPackageOrganizer default packages ];
		itemName: [ :package | package name ];
		filter: [ GtSpotterSubstringFilter new ];
		wantsToDisplayOnEmptyQuery: false
]

{ #category : #searches }
GtStreamingSpotterStart >> gtSpotterForToolsFor: aSearch [
	<gtSpotterSearch>

	^ aSearch list
		priority: 1;
		items: [ 
			{
				GtCoderStencil new . 
				GtMonitorStencil new . 
				GtRlGToolkitExamplesExplorer buildForGToolkitProject . 
				GtGitStencil new . 
				GtEpiceaStencil new . 
				GtTranscriptStencil new .
				GtFileSystemStencil new
			} ];
		"previewElement: [ :aStencil | aStencil asPreviewElement asElement ];"
		title: 'Tools';
		filter: [ GtSpotterSubstringFilter new ];
		wantsToDisplayOnEmptyQuery: true
]
