Extension { #name : #SoAccount }

{ #category : #'*GToolkit-Spotter' }
SoAccount >> gtSpotterPostsFor: aStep [
	<gtSearch>
	aStep listProcessor
		priority: 85;
		allCandidates: [ self allPosts ];
		itemName: #string;
		title: 'Posts';
		filter: GTFilterSubstring;
		wantsToDisplayOnEmptyQuery: true
]
