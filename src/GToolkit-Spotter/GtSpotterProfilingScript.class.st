"
To prifile ${class:GtSpotter}$ you can use the following code snippets.

A ${class:MessageTally}$ to profile all processes:
[[[
aTally := MessageTally new
		reportOtherProcesses: true;
		maxClassNameSize: 1000;
		maxClassPlusSelectorSize: 1000;
		maxTabs: 100.
]]]

A ${class:GtSpotter}$ with ==exited== flag to be able to finish profiling:
[[[
exited := false.
aSpotter := GtSpotter new initializeWith: GtSpotterStart new.
aSpotter announcer
	when: GtSpotterExitAnnouncement
	do: [ :anEvent | exited := true ].
]]]

A ${class:GtSpotterElement}$ that you want to inspect to be able to search something:
[[[
aSpotterElement := GtSpotterElement new
	spotterModel: aSpotter;
	size: 600 @ 400.
]]]


Execute the ${class:MessageTally}$ instance that will stop when you ${class:GtSpotterActOn}$ and Spotter will emit ${class:GtSpotterExitAnnouncement}$. An inspector is opened with profiling results at the end:
[[[
 [ aTally 
	spyAllEvery: MessageTally defaultPollPeriod 
	on: [ [ exited ] whileFalse: [ 
		1000 milliSeconds wait ].
		GtInspector openOn: aTally ] ] 
	forkNamed: 'Spotter Message Tally'.
]]]




"
Class {
	#name : #GtSpotterProfilingScript,
	#superclass : #Object,
	#category : #'GToolkit-Spotter-Profiling'
}
