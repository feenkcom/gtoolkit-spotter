Class {
	#name : #GtSpotterBrickDarkThemer,
	#superclass : #GLMBrickDarkThemer,
	#category : #'GToolkit-Spotter-Theme'
}

{ #category : #'brick-rubric' }
GtSpotterBrickDarkThemer >> rubricBackgroundColor [

	^ self spotterThemer backgroundColor
]

{ #category : #'brick-scrollbar' }
GtSpotterBrickDarkThemer >> scrollbarColor [

	^ Color black alpha: 0.5
]

{ #category : #'brick-scrollpane' }
GtSpotterBrickDarkThemer >> scrollpaneBackgroundColor [

	^ self spotterThemer backgroundColor
]
