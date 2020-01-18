Extension { #name : #GtResourceReference }

{ #category : #'*GToolkit-Spotter' }
GtResourceReference >> spotterForPathResourcesFor: aStep [
	<gtSearch>
	^ self utility spotterForPathResourcesFor: aStep
]

{ #category : #'*GToolkit-Spotter' }
GtResourceReference >> spotterForStringResourcesFor: aStep [
	<gtSearch>
	^ self utility spotterForStringResourcesFor: aStep
]

{ #category : #'*GToolkit-Spotter' }
GtResourceReference >> spotterPathResourceAtLocationsFor: aStep [
	<gtSearch>
	^ self utility spotterPathResourceAtLocationsFor: aStep
]

{ #category : #'*GToolkit-Spotter' }
GtResourceReference >> spotterStringResourcesAtLocationsFor: aStep [
	<gtSearch>
	^ self utility spotterStringResourcesAtLocationsFor: aStep
]
