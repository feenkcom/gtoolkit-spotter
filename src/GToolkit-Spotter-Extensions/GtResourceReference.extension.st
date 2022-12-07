Extension { #name : #GtResourceReference }

{ #category : #'*GToolkit-Spotter-Extensions' }
GtResourceReference >> spotterForPathResourcesFor: aStep [
	<gtSearch>
	^ self utility spotterForPathResourcesFor: aStep
]

{ #category : #'*GToolkit-Spotter-Extensions' }
GtResourceReference >> spotterForStringResourcesFor: aStep [
	<gtSearch>
	^ self utility spotterForStringResourcesFor: aStep
]

{ #category : #'*GToolkit-Spotter-Extensions' }
GtResourceReference >> spotterPathResourceAtLocationsFor: aStep [
	<gtSearch>
	^ self utility spotterPathResourceAtLocationsFor: aStep
]

{ #category : #'*GToolkit-Spotter-Extensions' }
GtResourceReference >> spotterStringResourcesAtLocationsFor: aStep [
	<gtSearch>
	^ self utility spotterStringResourcesAtLocationsFor: aStep
]
