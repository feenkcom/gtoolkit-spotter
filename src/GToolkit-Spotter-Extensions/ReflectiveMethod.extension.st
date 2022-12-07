Extension { #name : #ReflectiveMethod }

{ #category : #'*GToolkit-Spotter-Extensions' }
ReflectiveMethod >> gtSpotterForBytecodesFor: aStep [
	<gtSearch>
	compiledMethod spotterForBytecodesFor: aStep
]

{ #category : #'*GToolkit-Spotter-Extensions' }
ReflectiveMethod >> gtSpotterForImplementorsFor: aStep [
	<gtSearch>
	self compiledMethod spotterForImplementorsFor: aStep
]

{ #category : #'*GToolkit-Spotter-Extensions' }
ReflectiveMethod >> gtSpotterForMessagesFor: aStep [
	<gtSearch>
	self compiledMethod spotterForMessagesFor: aStep
]

{ #category : #'*GToolkit-Spotter-Extensions' }
ReflectiveMethod >> gtSpotterForSendersFor: aStep [
	<gtSearch>
	self compiledMethod spotterForSendersFor: aStep
]

{ #category : #'*GToolkit-Spotter-Extensions' }
ReflectiveMethod >> gtSpotterMethodClassFor: aStep [
	<gtSearch>
	self compiledMethod spotterMethodClassFor: aStep
]
