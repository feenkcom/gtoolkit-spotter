Extension { #name : #MooseModel }

{ #category : #'*GToolkit-Spotter' }
MooseModel >> gtSpotterClassesFor: aStep [
	<gtSearch>
	self spotter: 'All classes' on: [ self allClasses ] for: aStep
]

{ #category : #'*GToolkit-Spotter' }
MooseModel >> gtSpotterMethodsFor: aStep [
	<gtSearch>
	self spotter: 'All methods' on: [ self allMethods ] for: aStep
]
