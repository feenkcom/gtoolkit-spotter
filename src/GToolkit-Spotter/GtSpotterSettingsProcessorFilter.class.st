Class {
	#name : #GtSpotterSettingsProcessorFilter,
	#superclass : #GtSpotterProcessorFilter,
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
	
	^ (GtSpotterExtensionSettings shouldSpotterIgnoreProcessorDefinedInMethod: aMethod) not
]
