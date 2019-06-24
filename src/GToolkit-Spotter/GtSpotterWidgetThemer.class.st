Class {
	#name : #GtSpotterWidgetThemer,
	#superclass : #GLMBrickThemerModule,
	#category : #'GToolkit-Spotter-Theme'
}

{ #category : #values }
GtSpotterWidgetThemer >> backgroundColor [
	"used as background color for all panes"
	^ Color white
]

{ #category : #values }
GtSpotterWidgetThemer >> borderColor [
	"color that is used for border and dividers of UI parts of Spotter
	for example divider between header and results or between preview and list"
	^ Color r: 180 g: 180 b: 180 range: 255
]

{ #category : #values }
GtSpotterWidgetThemer >> breadcrumbHeight [

	^ 26
]

{ #category : #values }
GtSpotterWidgetThemer >> breadcrumbItemBackgroundColor [

	^ self borderColor
]

{ #category : #styles }
GtSpotterWidgetThemer >> breadcrumbItemLabelStyleFor: aBrick [

	aBrick
		textPosition: #center;
		padding: { 0 . self outerBorderWidth };
		vSpaceFill;
		hSpaceFill
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> breadcrumbItemLabelWidgetStyleFor: aBrick [

	aBrick
		color: self breadcrumbItemBackgroundColor;
		textColor: self breadcrumbItemTextColor
]

{ #category : #styles }
GtSpotterWidgetThemer >> breadcrumbItemStyleFor: aBrick [

	aBrick vSpaceFill
]

{ #category : #values }
GtSpotterWidgetThemer >> breadcrumbItemTextColor [

	^ Color white
]

{ #category : #styles }
GtSpotterWidgetThemer >> breadcrumbItemTriangleStyleFor: aBrick [

	aBrick
		height: self breadcrumbTriangleHeight;
		hSpaceFill
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> breadcrumbItemTriangleWidgetStyleFor: aBrick [

	aBrick
		renderer: (GtSpotterTriangleRenderer new orientation: #bottom).
		
	aBrick owner isTriangleVisible
		ifTrue:[ aBrick color: self breadcrumbItemBackgroundColor ]
		ifFalse: [ aBrick color: Color transparent ]
]

{ #category : #values }
GtSpotterWidgetThemer >> breadcrumbSeparatorColor [

	^ self breadcrumbItemBackgroundColor muchLighter slightlyDarker
]

{ #category : #values }
GtSpotterWidgetThemer >> breadcrumbSeparatorLineWidth [

	^ 2
]

{ #category : #styles }
GtSpotterWidgetThemer >> breadcrumbSeparatorStyleFor: aBrick [

	aBrick
		borderWidth: self breadcrumbSeparatorLineWidth;
		width: self breadcrumbSeparatorWidth;
		height: self breadcrumbHeight + self outerBorderWidth.
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> breadcrumbSeparatorWidgetStyleFor: aBrick [

	aBrick
		color: self breadcrumbItemBackgroundColor;
		borderColor: self breadcrumbSeparatorColor;
		renderer: GtSpotterBreadcrumbSeparatorRenderer new
]

{ #category : #values }
GtSpotterWidgetThemer >> breadcrumbSeparatorWidth [

	^ (self breadcrumbHeight + self outerBorderWidth) / 2 + 4 "we need slightly more because of drawing accuracy"
]

{ #category : #styles }
GtSpotterWidgetThemer >> breadcrumbStyleFor: aBrick [
	
	aBrick
		margin: { 0 . 0 };
		marginBottom: self breadcrumbTriangleHeight negated;
		height: self breadcrumbHeight + self breadcrumbTriangleHeight.
		
	aBrick layout
		zIndex: 2.
]

{ #category : #values }
GtSpotterWidgetThemer >> breadcrumbTriangleHeight [

	^ 16
]

{ #category : #values }
GtSpotterWidgetThemer >> buttonPressedColor [

	^ self backgroundColor darker
]

{ #category : #styles }
GtSpotterWidgetThemer >> categoryAmountStyleFor: aBrick [

	aBrick
		textPosition: #leftCenter.
	
	aBrick label
		familyName: self titleFamilyName.
	
	aBrick
		vSpaceFill;
		width: #approximateWidth;
		marginLeft: self categoryNameMarginRight.
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> categoryAmountWidgetStyleFor: aBrick [

	aBrick
		textColor: self titleTextColor;
		color: self titleBackgroundColor
]

{ #category : #values }
GtSpotterWidgetThemer >> categoryMarginBottom [

	^ (self itemHeight * (2/3)) ceiling "pixels"
]

{ #category : #values }
GtSpotterWidgetThemer >> categoryNameMarginLeft [

	^ self itemIconMaxWidth
]

{ #category : #values }
GtSpotterWidgetThemer >> categoryNameMarginRight [

	^ 10
]

{ #category : #styles }
GtSpotterWidgetThemer >> categoryStyleFor: aBrick [

	aBrick
		marginBottom: self categoryMarginBottom;
		hSpaceFill
]

{ #category : #values }
GtSpotterWidgetThemer >> categoryTitleBackgroundColor [

	^ self backgroundColor alpha: 0.95
]

{ #category : #styles }
GtSpotterWidgetThemer >> categoryTitleNameStyleFor: aBrick [

	aBrick
		vSpaceFill;
		textPosition: #leftCenter;
		width: [ :name | (aBrick owner innerBounds width) min: ((name label textSize x) + name label hMargin) ].
	
	aBrick label
		familyName: self titleFamilyName.
	
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> categoryTitleNameWidgetStyleFor: aBrick [

	aBrick
		textColor: self titleTextColor;
		color: self titleBackgroundColor
	
]

{ #category : #styles }
GtSpotterWidgetThemer >> categoryTitleShortcutStyleFor: aBrick [

	aBrick
		vSpaceFill;
		textPosition: #leftCenter;
		textColor: self titleTextColor.
	
	aBrick label
		familyName: 'Lucida Grande'.
	
]

{ #category : #styles }
GtSpotterWidgetThemer >> categoryTitleStyleFor: aBrick [

	aBrick
		useHorizontalLinearLayout;
		height: 30;
		hSpaceFill;
		paddingLeft: self categoryNameMarginLeft
	
	"aBrick layout
		floating: #stack;
		maxWidth: [ :title |
			aBrick hPadding + 
			(title nameBrick label textSize x )+ title amountBrick label textSize x +
			title nameBrick hPadding + title nameBrick hMargin + 
			title nameBrick label hPadding + title nameBrick label hMargin + 
			title amountBrick hMargin ]"
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> categoryTitleWidgetStyleFor: aBrick [

	aBrick
		normalColor: self categoryTitleBackgroundColor
]

{ #category : #styles }
GtSpotterWidgetThemer >> closeButtonStyleFor: aBrick [

	aBrick
		vSpaceFill;
		width: [ :m | m height ];
		margin: 10;
		marginLeft: 0
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> closeButtonWidgetStyleFor: aBrick [

	aBrick
		normalImage: GLMUIThemeExtraIcons glamorousClose;
		pressedColor: self buttonPressedColor
]

{ #category : #styles }
GtSpotterWidgetThemer >> dropDownPaneStyleFor: aBrick [

	aBrick
		layoutProperties: GLMBrickLayoutProperties new;
		marginTop: self innerBorderWidth;
		vSpaceFill;
		hSpaceFill
]

{ #category : #values }
GtSpotterWidgetThemer >> headerHeight [
	"height of the header where user enters search request"
	^ 56
]

{ #category : #styles }
GtSpotterWidgetThemer >> headerStyleFor: aBrick [

	aBrick
		hSpaceFill;
		height: self headerHeight
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> headerWidgetStyleFor: aBrick [

	aBrick
		color: self backgroundColor
]

{ #category : #styles }
GtSpotterWidgetThemer >> helpButtonStyleFor: aBrick [

	aBrick
		vSpaceFill;
		width: [ :m | m height ];
		margin: 10;
		marginLeft: 0
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> helpButtonWidgetStyleFor: aBrick [

	aBrick
		normalImage: GLMUIThemeExtraIcons glamorousHelp;
		pressedColor: self buttonPressedColor
]

{ #category : #styles }
GtSpotterWidgetThemer >> hintHideArrowStyleFor: aBrick [

	aBrick ifNil: [ ^ self ].
	(aBrick valueOfProperty: #brickSpotterIsReveal ifAbsent: [ false ])
		ifFalse: [ ^ self ].
	aBrick setProperty: #brickSpotterIsReveal toValue: false.
	
	(aBrick hasProperty: #brickSpotterBackupColor)
		ifTrue: [ aBrick color: (aBrick valueOfProperty: #brickSpotterBackupColor) ].
		
	aBrick changed
]

{ #category : #styles }
GtSpotterWidgetThemer >> hintHideStyleFor: aBrick [

	aBrick ifNil: [ ^ self ].
	(aBrick valueOfProperty: #brickSpotterIsReveal ifAbsent: [ false ])
		ifFalse: [ ^ self ].
	aBrick setProperty: #brickSpotterIsReveal toValue: false.
	
	(aBrick hasProperty: #brickSpotterBackupColor)
		ifTrue: [ aBrick color: (aBrick valueOfProperty: #brickSpotterBackupColor) ].
		
	(aBrick hasProperty: #brickSpotterBackupBorder)
		ifTrue: [ aBrick border: (aBrick valueOfProperty: #brickSpotterBackupBorder) ].
		
	aBrick changed
]

{ #category : #styles }
GtSpotterWidgetThemer >> hintRevealArrowStyleFor: aBrick [
	
	SmalltalkImage current vm canHandleShiftPressed
		ifTrue: [ ^ self ].
	
	aBrick ifNil: [ ^ self ].
	(aBrick valueOfProperty: #brickSpotterIsReveal ifAbsent: [ false ])
		ifTrue: [ ^ self ].
	
	aBrick setProperty: #brickSpotterBackupColor toValue: aBrick color.
	aBrick setProperty: #brickSpotterIsReveal toValue: true.
	
	aBrick color: self themer popupHelpThemer backgroundColor.
	
	aBrick changed
]

{ #category : #styles }
GtSpotterWidgetThemer >> hintRevealStyleFor: aBrick [
	
	SmalltalkImage current vm canHandleShiftPressed
		ifTrue: [ ^ self ].
	
	aBrick ifNil: [ ^ self ].
	(aBrick valueOfProperty: #brickSpotterIsReveal ifAbsent: [ false ])
		ifTrue: [ ^ self ].
	
	aBrick setProperty: #brickSpotterBackupColor toValue: aBrick color.
	aBrick setProperty: #brickSpotterBackupBorder toValue: aBrick border.
	aBrick setProperty: #brickSpotterIsReveal toValue: true.
	
	aBrick color: self themer popupHelpThemer backgroundColor.
	aBrick border: GLMBrickBorder new.
	aBrick borderColor: (self themer popupHelpThemer borderColor alpha: 0.6).
	aBrick borderWidth: self themer popupHelpThemer borderWidth.
	
	aBrick changed
]

{ #category : #icons }
GtSpotterWidgetThemer >> iconAct [
	^ self iconNamed: #glamorousAccept
]

{ #category : #icons }
GtSpotterWidgetThemer >> iconDiveIn [
	^ self iconNamed: #glamorousDiveRightIcon
]

{ #category : #icons }
GtSpotterWidgetThemer >> iconDiveInCategory [
	^ self iconNamed: #glamorousDiveAllRightIcon
]

{ #category : #values }
GtSpotterWidgetThemer >> innerBorderWidth [
	"width of the border that separates panes in the spotter"
	^ 1
]

{ #category : #styles }
GtSpotterWidgetThemer >> itemActionButtonStyleFor: aBrick [

	aBrick
		width: [ (self itemHeight / 1.1) floor ];
		vSpaceFill;
		margin: #(0 1);
		padding: { 0 . self outerBorderWidth }
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> itemActionButtonWidgetStyleFor: aBrick [

	aBrick
		pressedColor: self itemActionSelectedBackgroundColor
]

{ #category : #values }
GtSpotterWidgetThemer >> itemActionSelectedBackgroundColor [

	^ self itemSelectedBackgroundColor darker
]

{ #category : #styles }
GtSpotterWidgetThemer >> itemActionbarStyleFor: aBrick [

	aBrick
		useHorizontalLinearLayout;
		hShrinkWrap;
		vSpaceFill;
		marginRight: self outerBorderWidth + 2;
		visible: false
]

{ #category : #values }
GtSpotterWidgetThemer >> itemHeight [

	^  16 + Smalltalk ui theme labelFont height
]

{ #category : #values }
GtSpotterWidgetThemer >> itemHoveredBackgroundColor [

	^ self itemSelectedBackgroundColor alpha: 0.35
]

{ #category : #values }
GtSpotterWidgetThemer >> itemIconAlphaValue [

	^ 0.8
]

{ #category : #values }
GtSpotterWidgetThemer >> itemIconMaxWidth [

	^ 50
]

{ #category : #styles }
GtSpotterWidgetThemer >> itemIconStyleFor: aBrick [
	"icon form must already be set before styling"

	self flag: 'figure out why alpha doesn''t work'.
	aBrick
		"making icon a bit transparent"
		"normalImage: (aBrick normalImage asAlphaImageMorph alpha: self itemIconAlphaValue) imageForm;"
		width: self itemIconMaxWidth;
		vSpaceFill
]

{ #category : #styles }
GtSpotterWidgetThemer >> itemLabelStyleFor: aBrick [

	aBrick label
		highlightingLogic: [ :aCanvas :aRectangle | |bounds|
			"because font calculates text width wrong"
			bounds := aRectangle translateBy: (-3@0).
			aCanvas line: bounds bottomLeft to: bounds bottomRight width: 1 color: Color lightGray ].
	
	aBrick
		hSpaceFill;
		vSpaceFill;
		marginRight: self outerBorderWidth.
]

{ #category : #values }
GtSpotterWidgetThemer >> itemNormalBackgroundColor [

	^ Color transparent
]

{ #category : #styles }
GtSpotterWidgetThemer >> itemNormalStyleFor: aBrick [

	aBrick
		height: [ self itemHeight ];
		hSpaceFill
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> itemNormalWidgetStyleFor: aBrick [

	aBrick
		normalColor: self itemNormalBackgroundColor;
		selectedColor: self itemHoveredBackgroundColor;
		checkedColor: self itemSelectedBackgroundColor
]

{ #category : #values }
GtSpotterWidgetThemer >> itemSelectedBackgroundColor [

	^ self backgroundColor darker
]

{ #category : #values }
GtSpotterWidgetThemer >> outerBorderWidth [
	"the width of the border around the whole spotter"
	^ 4
]

{ #category : #values }
GtSpotterWidgetThemer >> previewArrowColor [

	^ self itemSelectedBackgroundColor
]

{ #category : #values }
GtSpotterWidgetThemer >> previewArrowGapHack [

	^ self themer scrollbarOffset + self themer scrollbarWidth + self outerBorderWidth + 1"pager bug"
]

{ #category : #values }
GtSpotterWidgetThemer >> previewArrowWidth [

	^ (self itemHeight / 2) + self previewArrowGapHack
]

{ #category : #values }
GtSpotterWidgetThemer >> previewBorderWidth [

	^ self outerBorderWidth
]

{ #category : #values }
GtSpotterWidgetThemer >> previewPaddingLeft [

	^ self previewArrowWidth * 1.2
]

{ #category : #values }
GtSpotterWidgetThemer >> previewPaddingRight [

	^ self previewPaddingLeft


]

{ #category : #values }
GtSpotterWidgetThemer >> previewWidthPercent [

	^ 40
]

{ #category : #values }
GtSpotterWidgetThemer >> privacyAgreementIsNotSendingDataColor [

	^ Color paleRed
]

{ #category : #values }
GtSpotterWidgetThemer >> privacyAgreementIsSendingDataColor [

	^ Color paleGreen
]

{ #category : #styles }
GtSpotterWidgetThemer >> privacyAgreementNotificationStyleFor: aBrick [

	| color |
	color := aBrick sendUsageData 
		ifTrue: [ self privacyAgreementIsSendingDataColor. ]
		ifFalse: [ self privacyAgreementIsNotSendingDataColor. ].
	aBrick messageBrick rubricTextFamilyName: StandardFonts defaultFont familyName.
	aBrick messageBrick rubricTextColor: Color black.
	aBrick
		color: color;
		borderColor: color darker;
		borderWidth: self outerBorderWidth;
		marginTop: 0
]

{ #category : #styles }
GtSpotterWidgetThemer >> resultsPaneStyleFor: aBrick [

	aBrick
		hSpaceFill: self resultsPaneWidth;
		vSpaceFill;
		with: [ :b | b band layout: GtSpotterStackedLayout new ]
]

{ #category : #values }
GtSpotterWidgetThemer >> resultsPaneWidth [
	"width in Percents of the results pane"
	^ 100"%"
]

{ #category : #values }
GtSpotterWidgetThemer >> searchFieldFamilyName [

	^ 'Source Sans Pro'
]

{ #category : #values }
GtSpotterWidgetThemer >> searchFieldFontSize [

	^ 15
]

{ #category : #values }
GtSpotterWidgetThemer >> searchFieldMarginLeft [

	^ 20
]

{ #category : #styles }
GtSpotterWidgetThemer >> searchFieldStyleFor: aBrick [
	
	aBrick
		beCentered;
		hSpaceFill;
		vSpaceFill;
		withoutMargins;
		withoutAdornment;
		withoutBorder;
		beTransparent;
		withGhostText: self spotterGhostText;
		autoAccept: true;
		marginLeft: self searchFieldMarginLeft;
		rubricTextFamilyName: self searchFieldFamilyName;
		rubricTextFontSize: self searchFieldFontSize.
	
	aBrick rubric ghostTextRuler
		fontName: self searchFieldFamilyName pointSize: self searchFieldFontSize.
]

{ #category : #values }
GtSpotterWidgetThemer >> searchFieldTextColor [
	
	^ Color black
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> searchFieldWidgetStyleFor: aBrick [
	
	aBrick morph
		color: Color transparent;
		textColor: self searchFieldTextColor;
		borderColor: Color transparent.
		
	aBrick morph textArea
		backgroundColor: Color transparent
]

{ #category : #styles }
GtSpotterWidgetThemer >> settingsButtonStyleFor: aBrick [

	aBrick
		vSpaceFill;
		width: [ :m | m height ];
		margin: #(10 0);
		marginRight: 2
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> settingsButtonWidgetStyleFor: aBrick [
	aBrick
		normalImage: (Smalltalk ui icons iconNamed: #glamorousPreferences);
		pressedColor: self buttonPressedColor
]

{ #category : #values }
GtSpotterWidgetThemer >> settingsLabelPadding [

	^ 4
]

{ #category : #values }
GtSpotterWidgetThemer >> settingsLabelSelectedTextColor [

	^ Color black
]

{ #category : #values }
GtSpotterWidgetThemer >> settingsLabelTextColor [

	^ Color white
]

{ #category : #styles }
GtSpotterWidgetThemer >> spotterContentsStyleFor: aBrick [
	
	aBrick
		useVerticalLinearLayout;
		borderWidth: self outerBorderWidth;
		padding: self outerBorderWidth;
		hSpaceFill;
		vSpaceFill.
	
	aBrick layout
		zIndex: 2
	
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> spotterContentsWidgetStyleFor: aBrick [
	
	aBrick
		borderColor: self borderColor;
		color: self borderColor
	
]

{ #category : #values }
GtSpotterWidgetThemer >> spotterGhostText [

	^ 'Search'
]

{ #category : #styles }
GtSpotterWidgetThemer >> spotterPaneStyleFor: aBrick [
	
	aBrick
		useHorizontalLinearLayout;
		hSpaceFill;
		vSpaceFill
]

{ #category : #styles }
GtSpotterWidgetThemer >> spotterPreviewArrowContainerStyleFor: aBrick [

	aBrick
		useVerticalLinearLayout;
		vSpaceFill;
		width: self previewArrowWidth;
		margin: {
			self headerHeight + self innerBorderWidth + self previewBorderWidth.
			0.
			self previewBorderWidth.
			self previewArrowGapHack negated }.
		
	aBrick layout
		zIndex: 4.
]

{ #category : #styles }
GtSpotterWidgetThemer >> spotterPreviewArrowStyleFor: aBrick [

	aBrick
		hSpaceFill;
		renderer: (GtSpotterTriangleRenderer new orientation: #right);
		height: [ (self previewArrowWidth - self previewArrowGapHack ) * 2 ]
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> spotterPreviewArrowWidgetStyleFor: aBrick [

	aBrick owner isTriangleVisible
		ifTrue: [
			aBrick color: self previewArrowColor.
			aBrick renderer borderColor: self borderColor ]
		ifFalse: [
			aBrick color: Color transparent.
			aBrick renderer borderColor: Color transparent ].
	
	GtSpotter isPreviewVisible
		ifTrue: [ 
			aBrick selectedColor: self borderColor.
			aBrick renderer border: 0 ]
		ifFalse: [
			aBrick selectedColor: Color transparent.
			aBrick renderer border: self outerBorderWidth ]
]

{ #category : #styles }
GtSpotterWidgetThemer >> spotterPreviewCompositeStyleFor: aBrick [

	aBrick
		hSpaceFill;
		vSpaceFill;
		margin: self previewBorderWidth;
		paddingLeft: self previewPaddingLeft
]

{ #category : #styles }
GtSpotterWidgetThemer >> spotterPreviewStyleFor: aBrick [
	
	aBrick
		borderWidth: self previewBorderWidth;
		hSpaceFill: self previewWidthPercent;
		vSpaceFill;
		margin: { self headerHeight + self innerBorderWidth. 0 . 0};
		marginLeft: (self previewBorderWidth + self previewArrowWidth) negated.
	
	aBrick layout
		zIndex: 1
]

{ #category : #'styles-widget' }
GtSpotterWidgetThemer >> spotterPreviewWidgetStyleFor: aBrick [
	
	aBrick
		borderColor: self borderColor;
		color: self backgroundColor
]

{ #category : #styles }
GtSpotterWidgetThemer >> spotterStyleFor: aBrick [

	aBrick brickRoot useVerticalLinearLayout
]

{ #category : #values }
GtSpotterWidgetThemer >> titleBackgroundColor [

	^ Color transparent
]

{ #category : #values }
GtSpotterWidgetThemer >> titleFamilyName [
	^ 'Open Sans'.
]

{ #category : #values }
GtSpotterWidgetThemer >> titleMarginLeft [
	^ 20
]

{ #category : #values }
GtSpotterWidgetThemer >> titleTextColor [

	^ self themer textLightColor
]
