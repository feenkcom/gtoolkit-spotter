Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-Spotter' }
BlockClosure >> gtFilter [
	^ self 
]

{ #category : #'*GToolkit-Spotter' }
BlockClosure >> gtIterator [
	" 1:filter 2:context[optional] "
	self assert: (self numArgs between: 1 and: 2). 
	
	^ GtSpotterBlockIterator new 
		onDo: self;
		yourself
]

{ #category : #'*GToolkit-Spotter' }
BlockClosure >> hasDynamicItems [
	^ self numArgs ~= 0
]