Class {
	#name : 'GtSpotterUIThreadStream',
	#superclass : 'GtSpotterStream',
	#instVars : [
		'spotterElement'
	],
	#category : 'GToolkit-Spotter-Utils'
}

{ #category : 'accessing' }
GtSpotterUIThreadStream >> attachedElementDo: aBlock [
	"spotterElement is a weak reference"
	spotterElement
		ifNil: [ ^ self ].
	(spotterElement at: 1) ifNotNil: aBlock
]

{ #category : 'gt-extensions' }
GtSpotterUIThreadStream >> attachedElementPreviewFor: aView [
	<gtView>
	^ aView forward
		title: 'Spotter element';
		priority: 5;
		object: [
			| anElement | 
			self attachedElementDo: [ :theElement | 
				anElement := theElement ].
			anElement ];
		view: #gtLiveFor:;
		actionUpdateButtonTooltip: 'Refresh attached element preview'
]

{ #category : 'accessing' }
GtSpotterUIThreadStream >> attachedTo: anElement [
	spotterElement := anElement asWeakReference
]

{ #category : 'performing' }
GtSpotterUIThreadStream >> performSymbol: aSymbol withArguments: aCollection receiver: aReceiver [
	| time |

	"we save current timestamp here, so that defer block can check if it belongs to the correct task"
	time := self timestamp.

	"if timestamp is wrong just skip command"
	self attachedElementDo: [ :anElement |
		anElement enqueueTask: (BlTaskAction new action: [
			time = self timestamp ifTrue: [ aReceiver perform: aSymbol withEnoughArguments: aCollection ] ]) ]
]
