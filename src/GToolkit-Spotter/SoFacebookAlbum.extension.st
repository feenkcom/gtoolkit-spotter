Extension { #name : #SoFacebookAlbum }

{ #category : #'*GToolkit-Spotter' }
SoFacebookAlbum >> gtSpotterPicturesFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 85;
		allCandidates: [ self pictures ];
		itemName: [ :x | '' ];
		itemIcon: [ :aPicture | 
			(aPicture asElement
				constraintsDo: [ :c | 
					c vertical exact: 50.
					c horizontal exact: 70 ]) asSpartaForm ];
		title: 'Pictures';
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
