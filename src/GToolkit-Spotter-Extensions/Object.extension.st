Extension { #name : #Object }

{ #category : #'*GToolkit-Spotter-Extensions' }
Object >> gtActionSearchFor: anAction [
	<gtAction>

	(GtSpotterSearchPragmasFuture hasSpotterSearch: self)
		ifFalse: [ ^ anAction noAction ].

	^ anAction explicit
		stencil: [ GtSpotterDropdownButtonStencil new
			id: GtSpotterObjectActionSearchId;
			actOn: [ :anActOnEvent :anItem :theButton | 
				anActOnEvent beActed.
				theButton phlow spawnTool: anActOnEvent toolToSend ];
			object: self ]
]

{ #category : #'*GToolkit-Spotter-Extensions' }
Object >> gtSpotterActDefaultFrom: aSpotterElement [
	^ GtInspector openOn: self from: aSpotterElement
]
