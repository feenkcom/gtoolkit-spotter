Class {
	#name : #GtSpotterByCharacterQuerySplitterExamples,
	#superclass : #GtSpotterQuerySplitterExamples,
	#category : #'GToolkit-Spotter-Examples-Examples'
}

{ #category : #utils }
GtSpotterByCharacterQuerySplitterExamples >> createQuerySplitter [
	^ GtSpotterByCharacterQuerySplitter new
]

{ #category : #examples }
GtSpotterByCharacterQuerySplitterExamples >> splitQueryWithNonDigitCharacters [
	<gtExample>
	self 
		assertSplitOf: 'One***Two---Three!@$Four'
		equals: #('One***Two---Three!@$Four').
]
