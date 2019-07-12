Extension { #name : #ReflectiveMethod }

{ #category : #'*GToolkit-Spotter' }
ReflectiveMethod >> gtSpotterForBytecodesFor: aStep [
	<gtSearch>
	compiledMethod spotterForBytecodesFor: aStep
]

{ #category : #'*GToolkit-Spotter' }
ReflectiveMethod >> gtSpotterForImplementorsFor: aStep [
	<gtSearch>
	self compiledMethod spotterForImplementorsFor: aStep
]

{ #category : #'*GToolkit-Spotter' }
ReflectiveMethod >> gtSpotterForMessagesFor: aStep [
	<gtSearch>
	self compiledMethod spotterForMessagesFor: aStep
]

{ #category : #'*GToolkit-Spotter' }
ReflectiveMethod >> gtSpotterForSendersFor: aStep [
	<gtSearch>
	self compiledMethod spotterForSendersFor: aStep
]

{ #category : #'*GToolkit-Spotter' }
ReflectiveMethod >> gtSpotterMethodClassFor: aStep [
	<gtSearch>
	self compiledMethod spotterMethodClassFor: aStep
]
