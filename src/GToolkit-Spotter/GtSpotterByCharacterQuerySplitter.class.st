Class {
	#name : #GtSpotterByCharacterQuerySplitter,
	#superclass : #GtSpotterQuerySplitter,
	#instVars : [
		'wordSeparators'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #accessing }
GtSpotterByCharacterQuerySplitter >> defaultWordSeparators [
	^ Array 
		with: Character space
]

{ #category : #printing }
GtSpotterByCharacterQuerySplitter >> description [
	^ 'Split by: ', wordSeparators printString
]

{ #category : #initialization }
GtSpotterByCharacterQuerySplitter >> initialize [
	super initialize.
	
	wordSeparators := self defaultWordSeparators
]

{ #category : #api }
GtSpotterByCharacterQuerySplitter >> splitQueryString: aString [
	^ ((aString trimBoth 
		splitOn: [:each | self wordSeparators includes: each ]) 
			reject: [ :each | each isEmpty ]) 
]

{ #category : #accessing }
GtSpotterByCharacterQuerySplitter >> wordSeparators [
	^wordSeparators
]

{ #category : #accessing }
GtSpotterByCharacterQuerySplitter >> wordSeparators: aCollectionOfCharacters [
	wordSeparators := aCollectionOfCharacters
]
