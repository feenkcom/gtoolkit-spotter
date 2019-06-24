Class {
	#name : #GtSpotterBrickThemer,
	#superclass : #GLMBrickThemer,
	#category : #'GToolkit-Spotter-Theme'
}

{ #category : #'brick-rubric' }
GtSpotterBrickThemer >> rubricBackgroundColor [

	^ self spotterThemer backgroundColor
]

{ #category : #'brick-scrollbar' }
GtSpotterBrickThemer >> scrollbarColor [

	^ Color lightGray alpha: 0.2
]

{ #category : #'brick-scrollpane' }
GtSpotterBrickThemer >> scrollpaneBackgroundColor [

	^ self spotterThemer backgroundColor
]
