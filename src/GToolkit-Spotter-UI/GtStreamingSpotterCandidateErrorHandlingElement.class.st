Class {
	#name : #GtStreamingSpotterCandidateErrorHandlingElement,
	#superclass : #BrHorizontalPane,
	#traits : 'TGtWithSpotterStep',
	#classTraits : 'TGtWithSpotterStep classTrait',
	#instVars : [
		'candidateElement'
	],
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #initialization }
GtStreamingSpotterCandidateErrorHandlingElement >> candidate: aStreamingSpotterCandidate search: aSpotterSearch [
	candidateElement id = GtSpotterBrokenSearchElementId asBlocElementId
		ifTrue: [
			| aNewCandidateElement |
			aNewCandidateElement := GtStreamingSpotterCandidateElement new spotterStep: spotterStep.
			[
				aNewCandidateElement candidate: aStreamingSpotterCandidate search: aSpotterSearch.
				candidateElement removeFromParent.
				self addChild: (candidateElement := aNewCandidateElement) ]
			on: Error
			do: [ :anError | candidateElement error: anError copy freeze search: aSpotterSearch ] ]
		ifFalse: [
			[ candidateElement candidate: aStreamingSpotterCandidate search: aSpotterSearch ]
				on: Error
				do: [ :anError |
					| aNewCandidateElement |
					aNewCandidateElement := GtStreamingSpotterBrokenSearchElement new spotterStep: spotterStep.
					aNewCandidateElement error: anError copy freeze search: aSpotterSearch.
					candidateElement removeFromParent.
					self addChild: (candidateElement := aNewCandidateElement)  ] ]
]

{ #category : #initialization }
GtStreamingSpotterCandidateErrorHandlingElement >> initialize [
	super initialize.
	
	self
		hMatchParent;
		vFitContent.
		
	self id: GtSpotterCandidateElementId.
	
	candidateElement := GtStreamingSpotterCandidateElement new.
	self addChild: candidateElement.
	
	self addAptitude: BrGlamorousListItemAptitude
]

{ #category : #'api - spotter step' }
GtStreamingSpotterCandidateErrorHandlingElement >> onSpotterStepChanged [
	"Is sent when a new spotterStep is assigned to the receiver.
	Note: #onSpotterStepChanged is sent before #subscribeToSpotterStep
	which means that if you perform any operation that triggers an announcement it will be ignored because the receiver
	didn't get a chance to subscribe to any announcement. Override #onPostSpotterStepChanged if you
	wish to perform an operation that requires an announcement, but keep in mind that this is not the most efficient way"
	<generatedFrom: #'TGtRobocoderWithObjectTraitTemplate>>#onObjectChangedTemplate'>
	
	candidateElement spotterStep: spotterStep
]
