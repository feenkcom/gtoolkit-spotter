Extension { #name : #Clipboard }

{ #category : #'*GToolkit-Spotter-Extensions' }
Clipboard >> recentItems [
	| currentClippings |
	currentClippings := self recentClippings.
	
	currentClippings isEmptyOrNil ifTrue: [ ^ #() ].
	^ currentClippings allButFirst reject: [ :each | 
		each isEmptyOrNil 
			or: [ each asString trimBoth isEmptyOrNil ] ]
]
