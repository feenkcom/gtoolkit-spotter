Extension { #name : #VirtualMachine }

{ #category : #'*GToolkit-Spotter' }
VirtualMachine >> canHandleShiftPressed [
	^ self interpreterSourceDate < 2015 asYear 
]
