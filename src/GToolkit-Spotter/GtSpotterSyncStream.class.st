Class {
	#name : #GtSpotterSyncStream,
	#superclass : #GtSpotterStream,
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #accessing }
GtSpotterSyncStream >> attachedTo: anElement [
]

{ #category : #performing }
GtSpotterSyncStream >> performSymbol: aSymbol withArguments: aCollection receiver: aReceiver [
	aReceiver
		perform: aSymbol
		withEnoughArguments: aCollection
]
