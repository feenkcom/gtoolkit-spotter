Extension { #name : #HelpTopic }

{ #category : #'*GToolkit-Spotter' }
HelpTopic >> gtSpotterForHelpTopicFor: aStep [
	<gtSearch>
	self
		flag: 'filter for multiple items like #title + #contents (combined by OR)'.
	self flag: #specialFilter.
	aStep listProcessor
		priority: 200;
		title: 'Help contents';
		items: [ self subtopics ];
		itemName: [ :helpTopic | helpTopic title ];
		itemIcon: [ :helpTopic | helpTopic gtTopicIcon ];
		itemFilterName: [ :helpTopic | helpTopic contents asString ];
		" the filter should only scan the contents / maybe title too ? "
			filter: GTFilterSubstrings;
		wantsToDisplayOnEmptyQuery: true
]
