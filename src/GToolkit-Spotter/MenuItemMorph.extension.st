Extension { #name : #MenuItemMorph }

{ #category : #'*GToolkit-Spotter' }
MenuItemMorph >> gtSpotterItemsFor: aStep [
	<gtSearch>
	self hasSubMenu
		ifTrue: [ self subMenu spotterItemsFor: aStep ]
]
