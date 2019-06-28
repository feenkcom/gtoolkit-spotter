Class {
	#name : #GtSpotterBreadcrumb,
	#superclass : #BrBreadcrumb,
	#instVars : [
		'spotterModel'
	],
	#category : #'GToolkit-Spotter-UI-Bloc'
}

{ #category : #initialization }
GtSpotterBreadcrumb >> initialize [
	super initialize.
	
	self look: BrGlamorousBreadcrumbLook new
]

{ #category : #'event handling' }
GtSpotterBreadcrumb >> onStepAdded: anAnnouncement [
]

{ #category : #'event handling' }
GtSpotterBreadcrumb >> onStepPopped: anAnnouncement [
]

{ #category : #accessing }
GtSpotterBreadcrumb >> spotterModel [
	^ spotterModel
]

{ #category : #accessing }
GtSpotterBreadcrumb >> spotterModel: aSpotterModel [
	
	spotterModel := aSpotterModel.
	
	spotterModel announcer when: GtSpotterStepAdded send: #onStepAdded: to: self.
	spotterModel announcer when: GtSpotterStepPopped send: #onStepPopped: to: self.
]
