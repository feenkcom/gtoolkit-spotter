Class {
	#name : 'GtSpotterProcessorFilter',
	#superclass : 'Object',
	#category : 'GToolkit-Spotter-Model'
}

{ #category : 'accessing' }
GtSpotterProcessorFilter >> configurationBlockForProcessorsCreatedBy: aMethod [
	"Return a block that takes one parameter (i.e., the processor) and
	can configure that processor before being used in Spotter."
	
	self subclassResponsibility
]

{ #category : 'testing' }
GtSpotterProcessorFilter >> shouldEnableProcessorsCreateBy: aMethod [
	"Return weather or not the processor created by the given method
	should be enabled in Spotter."
	
	self subclassResponsibility
]
