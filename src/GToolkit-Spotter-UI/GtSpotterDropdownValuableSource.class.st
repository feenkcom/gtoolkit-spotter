Class {
	#name : #GtSpotterDropdownValuableSource,
	#superclass : #GtSpotterDropdownSource,
	#instVars : [
		'valuable'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #'api - instance creation' }
GtSpotterDropdownValuableSource class >> receiver: aReceiver selector: aSelector [
	^ self valuable: (MessageSend 
		receiver: aReceiver 
		selector: aSelector)
]

{ #category : #'api - instance creation' }
GtSpotterDropdownValuableSource class >> valuable: aValuable [
	^ self new valuable: aValuable
]

{ #category : #'api - accessing' }
GtSpotterDropdownValuableSource >> object [
	^ self valuable value
]

{ #category : #'api - accessing' }
GtSpotterDropdownValuableSource >> valuable [
	^ valuable
]

{ #category : #'api - accessing' }
GtSpotterDropdownValuableSource >> valuable: aValuable [ 
	valuable := aValuable
]
