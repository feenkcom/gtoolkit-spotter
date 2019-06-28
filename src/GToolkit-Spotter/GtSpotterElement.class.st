Class {
	#name : #GtSpotterElement,
	#superclass : #BlElement,
	#instVars : [
		'spotterModel'
	],
	#category : #'GToolkit-Spotter-UI-Bloc'
}

{ #category : #accessing }
GtSpotterElement >> spotterModel: aSpotter [

	spotterModel := aSpotter.
	
	spotterModel announcer when: GtSpotterExitAnnouncement send: #closeSpotter to: self.
	spotterModel announcer when: GtSpotterShowPreview send: #onShowPreview to: self.
	spotterModel announcer when: GtSpotterHidePreview send: #onHidePreview to: self.
	
	self breadcrumbBrick spotterModel: spotterModel.
	self paneBrick spotterModel: spotterModel.
	
	spotterModel class isPreviewVisible
		ifTrue: [ spotterModel showPreview ]
]
