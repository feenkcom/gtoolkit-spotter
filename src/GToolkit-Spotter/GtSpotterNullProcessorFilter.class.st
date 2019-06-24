Class {
	#name : #GtSpotterNullProcessorFilter,
	#superclass : #GTSpotterProcessorFilter,
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
