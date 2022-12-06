Extension { #name : #Object }

{ #category : #'*GToolkit-Spotter' }
Object >> gtActionSearchFor: anAction [
	<gtAction>

	(GtSpotterUnorderedSearchesStream forOriginObject: self) isNotEmpty wait
		ifFalse: [ ^ anAction noAction ].

	^ anAction explicit
		stencil: [ GtSpotterDropdownButtonStencil new
			actOn: [ :anActOnEvent :anItem :theButton | 
				anActOnEvent beActed.
				theButton phlow spawnObject: anItem. ];
			object: self ]
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtIterator [
	^ Error signal: 'This is not a spotter iterator'
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterActDefault: aStep from: aSpotterElement [
	self gtSpotterActDefaultFrom: aSpotterElement.
	"if we exit spotter before default action we will not be able to dispatch opening of new spaces
	through the space in which spotter lives"
	aStep exit
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtSpotterActDefaultFrom: aSpotterElement [
	^ GtInspector openOn: self from: aSpotterElement
]

{ #category : #'*GToolkit-Spotter' }
Object >> hasDynamicItems [
	^ false
]
