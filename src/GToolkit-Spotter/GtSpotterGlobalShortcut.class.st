Class {
	#name : #GtSpotterGlobalShortcut,
	#superclass : #KMCategory,
	#category : #'GToolkit-Spotter-UI'
}

{ #category : #testing }
GtSpotterGlobalShortcut class >> isGlobalCategory [
	^ true
]

{ #category : #accessing }
GtSpotterGlobalShortcut class >> openGlobalSpotter [
	| spotterModel |
		
	self reset.
	spotterModel := GTSpotter new.
	
	self class environment at: #GTSpotterEventCollector ifPresent: [ :eventCollector |
		eventCollector new
			perform: #occupant: with: spotterModel;
			perform: #category: with: #spotter;
			register;
			perform: #linkToSpotter: with: spotterModel;
			perform: #recordSpotterOpenEvent ].
	
	GTSpotterMorph new
		extent: (World width / 2.4 @ (World height / 1.6)) asIntegerPoint;
		spotterModel: spotterModel;
		doLayout;
		openCenteredInWorld.
		
	spotterModel class markOpened.
]

{ #category : #accessing }
GtSpotterGlobalShortcut class >> openGlobalSpotterDebug [

	GTSpotterMorph new
		extent: (World width / 2.25 @ (World height / 1.25)) asIntegerPoint;
		spotterModel: (GTSpotter new
			beDebugging;
			yourself);
		openInWindowLabeled: 'Spotter Debug Mode';
		showPreview
]

{ #category : #cleanup }
GtSpotterGlobalShortcut class >> reset [
	
	(World findA: GTSpotterMorph) ifNotNil: [ :aSpotterMorph | aSpotterMorph spotterModel exitDueTo: #reset ]
]

{ #category : #shortcuts }
GtSpotterGlobalShortcut >> keymapToggle [
	"KMRepository reset"
	<shortcut>
	^ KMKeymap
			shortcut: Character cr shift
			action: [ self class openGlobalSpotter ]
]

{ #category : #shortcuts }
GtSpotterGlobalShortcut >> keymapToggleDebug [
	"KMRepository reset"
	"This shortcut is still using command because the current Virtual Machine interprets Ctrl-cr as a different KEY.
	This should be replaced for #meta as soon as the new VMs are fixed and shipped"
	<shortcut>
	^ KMKeymap
			shortcut: Character cr command shift
			action: [ self class openGlobalSpotterDebug ]
]
