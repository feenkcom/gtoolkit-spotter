Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-Spotter' }
BlockClosure >> hasDynamicItems [
	^ self numArgs ~= 0
]
