Extension { #name : #BlSpace }

{ #category : #'*GToolkit-Spotter' }
BlSpace >> withSpotter [
	self root addShortcut: (BlShortcut new
		repeatable: false;
		combination: BlKeyCombination shiftReturn;
		action: [ GtWorld openSpotter ])
]
