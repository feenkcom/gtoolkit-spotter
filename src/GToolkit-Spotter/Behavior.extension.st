Extension { #name : #Behavior }

{ #category : #'*GToolkit-Spotter' }
Behavior >> withMethodsReferTo: aLiteral do: aBlock [
	| specialIndex |
	specialIndex := Smalltalk specialSelectorIndexOrNil: aLiteral.
	self methodsDo: [ :method | 
		((method hasLiteral: aLiteral) 
			or: [ specialIndex notNil and: [ method scanFor: method encoderClass firstSpecialSelectorByte + specialIndex ] ])
				ifTrue: [ aBlock value: method ] ]
]

{ #category : #'*GToolkit-Spotter' }
Behavior >> withThorougMethodsReferTo: aLiteral do: aBlock [
	| specialIndex |
	specialIndex := Smalltalk specialSelectorIndexOrNil: aLiteral.
	self methodsDo: [ :method | 
		(method hasSelector: aLiteral specialSelectorIndex: specialIndex)
					ifTrue: [ aBlock value: method ] ].
]
