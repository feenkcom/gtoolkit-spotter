Class {
	#name : #GtSpotterFiltersConfiguration,
	#superclass : #Object,
	#instVars : [
		'configurationById'
	],
	#classInstVars : [
		'default'
	],
	#category : #'GToolkit-Spotter-Model'
}

{ #category : #accessing }
GtSpotterFiltersConfiguration class >> default [
	^ default ifNil: [
		default := self new ]
]

{ #category : #views }
GtSpotterFiltersConfiguration class >> gtViewDefaultConfigurationsFor: aView [
	<gtView>
	<gtClassView>
	
	^ aView forward
		title: 'Default configurations';
		priority: 10;
		object: [ self default ];
		view: #gtConfigurationByIdFor:
]

{ #category : #api }
GtSpotterFiltersConfiguration >> applyConfigurationWithId: aFilterConfigurationId onFilter: aSearchFilter [
	self 
		configurationAt: aFilterConfigurationId 
		ifPresent: [ :aFilterConfiguration |
			aFilterConfiguration applyOnFilter: aSearchFilter ]
]

{ #category : #accessing }
GtSpotterFiltersConfiguration >> configurationAt: aFilterConfigurationId ifPresent: aBlockClosure [ 
	configurationById
		at: aFilterConfigurationId
		ifPresent: aBlockClosure
]

{ #category : #accessing }
GtSpotterFiltersConfiguration >> configurationAt: aFilterConfigurationId put: aFilterConfiguration [ 
	configurationById
		at: aFilterConfigurationId
		put: aFilterConfiguration
]

{ #category : #views }
GtSpotterFiltersConfiguration >> gtConfigurationByIdFor: aView [
	<gtView>
	
	configurationById ifNil: [ ^ aView empty ].
	
	^ aView columnedList
		title: 'Configurations';
		items: [ configurationById associations ];
		column: 'Id' text: [ :each | each key gtDisplayString ] width: 200;
		column: 'Configuration' text: [ :each | each value gtDisplayString ];
		send: [ :each | each value ]
]

{ #category : #'initialization ' }
GtSpotterFiltersConfiguration >> initialize [
	super initialize.
	
	configurationById := OrderedDictionary new.
]

{ #category : #accessing }
GtSpotterFiltersConfiguration >> putConfiguration: aFilterConfiguration [
	self 
		configurationAt: aFilterConfiguration extensionId 
		put: aFilterConfiguration
]

{ #category : #accessing }
GtSpotterFiltersConfiguration >> putSubstringsConfigurationWithId: anExtensionId with: aConfigurationBlock [
	| filterConfiguration |
	
	filterConfiguration := GtSpotterSubstringsFilterConfiguration new.
	filterConfiguration extensionId: anExtensionId.
	aConfigurationBlock value: filterConfiguration.
	
	self putConfiguration: filterConfiguration 
]

{ #category : #accessing }
GtSpotterFiltersConfiguration >> removeConfigurationWithId: aFilterConfigurationId [ 
	configurationById
		removeKey: aFilterConfigurationId
		ifAbsent: [ ]
]
