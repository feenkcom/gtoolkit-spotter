Class {
	#name : 'GtSpotterDropdownSource',
	#superclass : 'Object',
	#category : 'GToolkit-Spotter-Stencils'
}

{ #category : 'api - accessing' }
GtSpotterDropdownSource >> object [
	"Return an object that is used to initialize Spotter search:
	${method:GtSpotter>>#initializeWith:}$"
	^ self subclassResponsibility
]

{ #category : 'api - accessing' }
GtSpotterDropdownSource >> value [
	^ self object
]
