Class {
	#name : #GtSpotterSettingsProcessorFilter,
	#superclass : #GTSpotterProcessorFilter,
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #testing }
GtSpotterSettingsProcessorFilter >> configurationBlockForProcessorsCreatedBy: aMethod [
	"No need to configure anything."
	
	^ [ :processor | ]
]

{ #category : #testing }
GtSpotterSettingsProcessorFilter >> shouldEnableProcessorsCreateBy: aMethod [
	"Enable everything."
	
	^ (GTSpotterExtensionSettings shouldSpotterIgnoreProcessorDefinedInMethod: aMethod) not
]
