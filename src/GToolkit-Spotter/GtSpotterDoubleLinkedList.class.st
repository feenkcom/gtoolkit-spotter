Class {
	#name : #GtSpotterDoubleLinkedList,
	#superclass : #DoubleLinkedList,
	#category : #'GToolkit-Spotter-Utils'
}

{ #category : #accessing }
GtSpotterDoubleLinkedList >> head [

	^ head
]

{ #category : #accessing }
GtSpotterDoubleLinkedList >> head: aDoubleLink [

	head := aDoubleLink
]

{ #category : #enumerating }
GtSpotterDoubleLinkedList >> linksDo: aBlock [
	| current |
	current := head.
	[ current isNil ] 
		whileFalse: [ 
	 		aBlock value: current.
			current := current nextLink ]
]

{ #category : #'as yet unclassified' }
GtSpotterDoubleLinkedList >> removeCycledLink: link [
	| predecessor successor |
	predecessor := link previousLink.
	successor := link nextLink.
	predecessor
		ifNil: [ head := successor ]
		ifNotNil: [ predecessor nextLink: successor ].
	successor
		ifNil: [ tail := predecessor ]
		ifNotNil: [ successor previousLink: predecessor ].
	link clearLinks.
	
	"I'm the only one left, clear linked list and return"
	(link = head & (link = tail)) ifTrue: [ head := nil. tail := nil. ^ link ].
	
	link = head ifTrue: [ head := successor ].
	link = tail ifTrue: [ tail := predecessor ].
	
	^ link
]

{ #category : #accessing }
GtSpotterDoubleLinkedList >> tail [

	^ tail
]

{ #category : #accessing }
GtSpotterDoubleLinkedList >> tail: aDoubleLink [

	tail := aDoubleLink
]
