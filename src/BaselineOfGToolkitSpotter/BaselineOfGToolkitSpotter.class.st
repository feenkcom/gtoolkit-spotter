"
!Spotter

Spotter is a universal search interface. Like in the case of the ${class:BaselineOfGToolkitInspector|label=Inspector}$, we accomplish this through a moldable interface.

Search always happens in a context of an object. The default Spotter opens in a default context and can multiple kinds of searches like ==Object==, for a class or ==./== for the local folder.

${example:GtSpotterElementExamples>>#elementOnDefaultSpotter|noCode|previewShow=#gtLiveFor:}$

The actual search is executed through a processor. Each processor has a name, and is presented in the search result in the form of a search category. Through this, every search yields  results  in possibly multiple categories of results. For example, in the default context we get.

${example:GtSpotterStepExamples>>#defaultStep|noCode|previewShow=gtProcessorsFor:}$


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
				spec repository: 'github://feenkcom/Brick:v0.7.423/src' ];
			baseline: 'GToolkitExamples' with: [
				spec repository: 'github://feenkcom/gtoolkit-examples:v0.7.13/src' ].
		spec 
			package: 'GToolkit-Spotter' with: [
				spec requires: #(#Brick ). ];
			package: 'GToolkit-Spotter-Examples' with: [
				spec requires: #(#GToolkitExamples #'GToolkit-Spotter' ). ]. ].

]
