Extension { #name : #Clipboard }

{ #category : #'*GToolkit-Spotter-Extensions' }
Clipboard >> recentItems [
	recent isEmptyOrNil ifTrue: [ ^ #() ].
	^ recent allButFirst reject: [ :each | 
		each isEmptyOrNil 
			or: [ each asString trimBoth isEmptyOrNil ] ]
]
