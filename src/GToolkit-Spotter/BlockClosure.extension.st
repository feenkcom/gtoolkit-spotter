Extension { #name : #BlockClosure }

{ #category : #'*GToolkit-Spotter' }
BlockClosure >> gtIterator [
	" 1:filter 2:context[optional] "
	self assert: (self numArgs between: 1 and: 2). 
	
	^ GTSpotterBlockIterator new 
		onDo: self;
		yourself
]

{ #category : #'*GToolkit-Spotter' }
BlockClosure >> hasDynamicItems [
	^ self numArgs ~= 0
]
