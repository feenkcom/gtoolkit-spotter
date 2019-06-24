Class {
	#name : #GtSpotterStepBreadcrumbItem,
	#superclass : #GLMInteractableBrick,
	#instVars : [
		'labelBrick',
		'triangleBrick',
		'stepModel',
		'isTriangleVisible'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #actions }
GtSpotterStepBreadcrumbItem >> click: evt [
	super click: evt.
	
	self stepModel spotter popUntil: self stepModel.
	^ true
]

{ #category : #actions }
GtSpotterStepBreadcrumbItem >> deselect [
	
	self invalidateWith: [
		self labelBrick label customFont; beRegular ]
]

{ #category : #actions }
GtSpotterStepBreadcrumbItem >> hideTriangle [

	isTriangleVisible := false.
	self themer spotterThemer breadcrumbItemTriangleWidgetStyleFor: self triangleBrick
]

{ #category : #initialization }
GtSpotterStepBreadcrumbItem >> initialize [
	super initialize.
	
	self
		useVerticalLinearLayout;
		labelBrick: self newLabelBrick;
		triangleBrick: self newTriangleBrick;
		enable
	
]

{ #category : #testing }
GtSpotterStepBreadcrumbItem >> isTriangleVisible [

	^ isTriangleVisible ifNil: [ isTriangleVisible := true ]
]

{ #category : #accessing }
GtSpotterStepBreadcrumbItem >> labelBrick [

	^ labelBrick
]

{ #category : #accessing }
GtSpotterStepBreadcrumbItem >> labelBrick: aBrick [

	labelBrick := aBrick.
	
	self themer spotterThemer breadcrumbItemLabelStyleFor: self labelBrick.
	self addBrickBack: self labelBrick
]

{ #category : #'instance creation' }
GtSpotterStepBreadcrumbItem >> newLabelBrick [

	^ GLMLabelBrick new
]

{ #category : #'instance creation' }
GtSpotterStepBreadcrumbItem >> newTriangleBrick [

	^ GLMBrick new
]

{ #category : #'brick-properties-events' }
GtSpotterStepBreadcrumbItem >> onThemerChanged [
	super onThemerChanged.
	
	self themer spotterThemer breadcrumbItemLabelWidgetStyleFor: self labelBrick.
	self themer spotterThemer breadcrumbItemTriangleWidgetStyleFor: self triangleBrick
]

{ #category : #actions }
GtSpotterStepBreadcrumbItem >> select [
	
	self invalidateWith: [
		self labelBrick label customFont; beBold ]
]

{ #category : #actions }
GtSpotterStepBreadcrumbItem >> showTriangle [

	isTriangleVisible := true.
	self themer spotterThemer breadcrumbItemTriangleWidgetStyleFor: self triangleBrick
]

{ #category : #accessing }
GtSpotterStepBreadcrumbItem >> stepModel [
	^ stepModel
]

{ #category : #accessing }
GtSpotterStepBreadcrumbItem >> stepModel: anObject [
	stepModel := anObject
]

{ #category : #accessing }
GtSpotterStepBreadcrumbItem >> text: aString [

	self labelBrick text: aString.
	self doLayoutForce
]

{ #category : #accessing }
GtSpotterStepBreadcrumbItem >> triangleBrick [

	^ triangleBrick
]

{ #category : #accessing }
GtSpotterStepBreadcrumbItem >> triangleBrick: aBrick [

	triangleBrick := aBrick.
	
	self themer spotterThemer breadcrumbItemTriangleStyleFor: self triangleBrick.
	self addBrickBack: self triangleBrick
]
