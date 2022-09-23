Extension { #name : #Collection }

{ #category : #'*GToolkit-Spotter' }
Collection >> gtIterator [
	^ [ :filter | self do: filter ] gtIterator
]
