Class {
	#name : #GtSpotterNullProcessorFilter,
	#superclass : #GtSpotterProcessorFilter,
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #testing }
GtSpotterNullProcessorFilter >> configurationBlockForProcessorsCreatedBy: aMethod [
	"No need to configure anything."
	
	^ [ :processor | ]
]

{ #category : #testing }
GtSpotterNullProcessorFilter >> shouldEnableProcessorsCreateBy: aMethod [
	"Enable everything."
	
	^ true
]
