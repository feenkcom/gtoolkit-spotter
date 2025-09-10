Extension { #name : #Clipboard }

{ #category : #'*GToolkit-Spotter-Extensions' }
Clipboard >> currentClippings [
	^ self 
		forPharo12AndNewer: [self recentClippings] 
		forPharo11: [ recent ]
]

{ #category : #'*GToolkit-Spotter-Extensions' }
Clipboard >> recentItems [
	| currentClippings |
	currentClippings := self currentClippings.
	
	currentClippings isEmptyOrNil ifTrue: [ ^ #() ].
	^ currentClippings allButFirst reject: [ :each | 
		each isEmptyOrNil 
			or: [ each asString trimBoth isEmptyOrNil ] ]
]
