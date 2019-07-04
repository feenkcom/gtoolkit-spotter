Class {
	#name : #GtSpotterWithPreview,
	#superclass : #GtSpotterElement,
	#instVars : [
		'previewElement',
		'labelElement'
	],
	#category : #'GToolkit-Spotter-UI-Bloc'
}

{ #category : #initialization }
GtSpotterWithPreview >> initialize [
	super initialize.
	
	previewElement := BlElement new.
	previewElement viewModel: BrPagerPageModel new.
	previewElement layout: BlLinearLayout vertical.
	previewElement constraintsDo: [ :c |
		c horizontal matchParent.
		c vertical matchParent ].
	previewElement padding: (BlInsets all: 10).
	
	labelElement := BrLabel new
		look: (BrGlamorousLabelLook new foreground: Color gray);
		alignCenter;
		hMatchParent;
		vFitContent.
	
	previewElement addChild: labelElement.
	
	previewElement addChild: (BlElement new
		margin: (BlInsets all: 5);
		constraintsDo: [ :c |
			c horizontal matchParent.
			c vertical matchParent ]) as: #previewContent.

	previewElement visibility: BlVisibility gone.
	
	results addPage: previewElement
]

{ #category : #'event - handling' }
GtSpotterWithPreview >> onHidePreview [
	previewElement visibility: BlVisibility gone
]

{ #category : #'event - handling' }
GtSpotterWithPreview >> onSelectedCandidateChanged: anAnnouncement [
	| anObject aPreviewContainer |
	
	anObject := anAnnouncement selected item.
	
	aPreviewContainer := previewElement
		childNamed: #previewContent
		ifFound: #yourself
		ifNone: [ previewElement ].
	aPreviewContainer removeChildren.
	
	(anObject gtViewsFor: GtPhlowView empty)  originalView asElementDo: [ :anElement |
		aPreviewContainer addChild: anElement ].
	
	labelElement text: anObject gtDisplayText.
	
	spotterModel class isPreviewVisible
		ifTrue: [ previewElement visibility: BlVisibility visible. ]
]

{ #category : #'event - handling' }
GtSpotterWithPreview >> onShowPreview [

	self spotterModelDo: [ :aSpotterModel | aSpotterModel hasSelected
			ifFalse: [ ^ self ] ].

	previewElement visibility: BlVisibility visible.
	
]

{ #category : #accessing }
GtSpotterWithPreview >> spotterModel [
	^ spotterModel
]

{ #category : #accessing }
GtSpotterWithPreview >> spotterModel: aSpotterModel [
	super spotterModel: aSpotterModel.
	
	self when: GtPhlowObjectToSelect do: [ :anEvent | anEvent consumed: anEvent sourceElement == self ].

	spotterModel announcer when: GtSpotterShowPreview send: #onShowPreview to: self.
	spotterModel announcer when: GtSpotterHidePreview send: #onHidePreview to: self.
	spotterModel announcer when: GtSpotterSelectedCandidateChanged send: #onSelectedCandidateChanged: to: self.
	
	spotterModel class isPreviewVisible
		ifTrue: [ spotterModel showPreview ]
]
