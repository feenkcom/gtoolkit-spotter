Extension { #name : #Pragma }

{ #category : #'*GToolkit-Spotter-Extensions' }
Pragma >> gtSpotterActDefaultFrom: aSpotterElement [
    ^ super gtSpotterActDefaultFrom: aSpotterElement
]

{ #category : #'*GToolkit-Spotter-Extensions' }
Pragma >> gtSpotterForBytecodesFor: aStep [
	<gtSearch>
	^ self method spotterForBytecodesFor: aStep
]

{ #category : #'*GToolkit-Spotter-Extensions' }
Pragma >> gtSpotterForImplementorsFor: aStep [
	<gtSearch>
	^ self method spotterForImplementorsFor: aStep
]

{ #category : #'*GToolkit-Spotter-Extensions' }
Pragma >> gtSpotterForSendersFor: aStep [
	<gtSearch>
	^ self method spotterForSendersFor: aStep
]
