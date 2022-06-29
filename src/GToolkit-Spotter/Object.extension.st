Extension { #name : #Object }

{ #category : #'*GToolkit-Spotter' }
Object >> asGtSpotterCandidateLink [

	^ GtSpotterCandidateLink value: self
]

{ #category : #'*GToolkit-Spotter' }
Object >> asGtSpotterProcessorLink [

	^ GtSpotterProcessorLink value: self
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtActionSearchFor: anAction [
	<gtAction>
	| fakeStep |
	fakeStep := GtSpotter new newStep origin: self.
	self gtSpotterProcessorsFor: fakeStep.
	fakeStep processors isEmpty
		ifTrue: [ ^ anAction noAction ].
	^ anAction explicit
		stencil: [ GtSpotterDropdownButtonStencil new
			object: self;
			actOn: [ :anActOnEvent :anItem :aButton | 
				aButton phlow spawnObject: anItem.
				anActOnEvent beActed ] ]
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtFilter [
	^ GtFilterBlock gtFilter
		
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtIterator [
	^ Error signal: 'This is not a spotter iterator'
]

{ #category : #'*GToolkit-Spotter' }
Object >> gtListFilter [
	^ GTFilterSubstring new
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
Object >> gtSpotterProcessorsFor: aSpotterStep [
	<return: #Collection of: #Pragma>
	^ GtSpotterProcessorsCollector new 
		fromObject: self;
		spotterStep: aSpotterStep;
		collect
]

{ #category : #'*GToolkit-Spotter' }
Object >> hasDynamicItems [
	^ false
]
