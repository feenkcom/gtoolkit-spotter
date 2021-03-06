"
!Spotter
Spotter is a universal search interface. Like in the case of the ${class:BaselineOfGToolkitInspector|label=Inspector}$, we accomplish this through a moldable interface.

Search always happens in a context of an object. The default Spotter opens in a default context and can multiple kinds of searches like ==Object==, for a class or ==./== for the local folder.

${example:GtSpotterElementExamples>>#elementOnDefaultSpotter|noCode|previewShow=#gtLiveFor:}$

The actual search is executed through a processor. Each processor has a name, and is presented in the search result in the form of a search category. Through this, every search yields  results  in possibly multiple categories of results. For example, in the default context we get.

${example:GtSpotterStepExamples>>#defaultStep|noCode|previewShow=gtProcessorsFor:}$
!!Molding search
A Spotter search is like an inspector view: it's a method implemented in a class of the object in the context of which we want to search. The global Spotter starts from an instance of ${class:GtSpotterStart}$. This one has methods like  ${method:GtSpotterStart>>#gtSpotterForClassesFor:|expanded=}$ which is responsible for searching for classes and traits in the image:

Such search methods can be defined in any class.

To learn from similar methods, you can ${class:GtWorkWithQueriesHowToGuide|label='query the code'}$ :

[[[
#gtSearch gtPragmas
]]]


"
Class {
	#name : #BaselineOfGToolkitSpotter,
	#superclass : #BaselineOf,
	#category : #BaselineOfGToolkitSpotter
}

{ #category : #baseline }
BaselineOfGToolkitSpotter >> baseline: spec [
	<baseline>
	spec for: #'common' do: [
		spec 
			baseline: 'Brick' with: [
				spec repository: 'github://feenkcom/Brick/src' ];
			baseline: 'GToolkitExamples' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples/src' ].
		spec 
			package: 'GToolkit-Spotter' with: [
				spec requires: #(#Brick) ];
			package: 'GToolkit-Spotter-Examples' with: [
				spec requires: #(#GToolkitExamples #'GToolkit-Spotter' ). ]. ].
]
