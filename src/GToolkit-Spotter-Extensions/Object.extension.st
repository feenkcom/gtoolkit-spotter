Extension { #name : #Object }

{ #category : #'*GToolkit-Spotter-Extensions' }
Object >> gtActionSearchFor: anAction [
	<gtAction>

	(GtSpotterUnorderedSearchesStream forOriginObject: self) isNotEmpty wait
		ifFalse: [ ^ anAction noAction ].

	^ anAction explicit
		stencil: [ GtSpotterDropdownButtonStencil new
			actOn: [ :anActOnEvent :anItem :theButton | 
				anActOnEvent beActed.
				theButton phlow spawnTool: anActOnEvent toolToSend ];
			object: self ]
]

{ #category : #'*GToolkit-Spotter-Extensions' }
Object >> gtSpotterActDefaultFrom: aSpotterElement [
	^ GtInspector openOn: self from: aSpotterElement
]
