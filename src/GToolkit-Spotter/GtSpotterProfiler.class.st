Class {
	#name : #GtSpotterProfiler,
	#superclass : #KMCategory,
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #testing }
GtSpotterProfiler class >> isGlobalCategory [
	^ true
]

{ #category : #profiling }
GtSpotterProfiler class >> profileOneCycle [
	"Tally only the UI process"
	
	(self confirm: 'MessageTally the UI process one cycle')
		ifTrue: [TimeProfiler
			onBlock: [
				|spotterModel done|
				done := false.
				GtSpotterGlobalShortcut reset.
				spotterModel := GtSpotter new.
				
				spotterModel announcer when: GtSpotterSearchFinished do: [ done := true ].
					
				GtSpotterMorph new
					extent: (World width / 2.4 @ (World height / 1.6)) asIntegerPoint;
					spotterModel: spotterModel;
					openCenteredInWorld.
		
				spotterModel class markOpened.
				[ done ] whileFalse: [ World doOneCycle ] ] ]
]

{ #category : #shortcuts }
GtSpotterProfiler >> keymapProfileOneCycle [
	"KMRepository reset"
	<shortcut>
	^ KMKeymap
			shortcut: $u meta
			action: [ self class profileOneCycle ]
]
