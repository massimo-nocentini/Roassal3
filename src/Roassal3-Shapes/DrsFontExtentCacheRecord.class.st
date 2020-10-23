Class {
	#name : #DrsFontExtentCacheRecord,
	#superclass : #Object,
	#instVars : [
		'font',
		'height',
		'widthArray',
		'heightArray',
		'otherExtents'
	],
	#category : #'Roassal3-Shapes-Text'
}

{ #category : #constants }
DrsFontExtentCacheRecord class >> coveredCodePoints [

	^2000
]

{ #category : #private }
DrsFontExtentCacheRecord >> computeExtentsOfAscii: cval [
	| ext |
	ext := CairoFontMetricsProvider new
		font: font;
		extentsOf: (Character value: cval) asString.
	^RSTextExtents new
		from: ext;
		yourself.
	
	 
]

{ #category : #private }
DrsFontExtentCacheRecord >> computeHeightOf: cval [
	| ext |
	ext := self computeExtentsOfAscii: cval.
	otherExtents at: cval put: ext.
	(widthArray at: cval) ifNil: [widthArray at: cval put: ext width].
	^ext height
]

{ #category : #'text extents' }
DrsFontExtentCacheRecord >> computeTextExtentsOf: aText [

	| width te |
	width := aText asString sum: [ :each | self widthOf: each ].
	te := self extentsOf: aText first.
	^ RSTextExtents new
		  width: width;
		  height: height;
		  x_advance: te x_advance;
		  x_bearing: te x_bearing;
		  y_bearing: (self height - font realFont descent) negated asFloat;
		  y_advance: te y_advance;
		  yourself
]

{ #category : #private }
DrsFontExtentCacheRecord >> computeWidthOf: cval [
	| ext |
	ext := self computeExtentsOfAscii: cval.
	otherExtents at: cval put: ext.
	(heightArray at: cval) ifNil: [heightArray at: cval put: ext height].
	^ext x_advance
]

{ #category : #API }
DrsFontExtentCacheRecord >> extentsOf: aCharacter [
	"Try to avoid this call, rather use #widthOf: or #heigthOf:"

	^otherExtents at: aCharacter asciiValue ifAbsentPut: [self computeExtentsOfAscii: aCharacter asciiValue] 
]

{ #category : #API }
DrsFontExtentCacheRecord >> font: aFont [ 

	font := aFont.
	height := aFont height.
]

{ #category : #API }
DrsFontExtentCacheRecord >> height [
	^height
]

{ #category : #API }
DrsFontExtentCacheRecord >> heightOf: aCharacter [
	| cval |
	
	cval := aCharacter asciiValue.
	(cval between: 1 and: self class coveredCodePoints) ifTrue: [
		^(heightArray at: cval) ifNil: [ heightArray at: cval put: (self computeHeightOf: cval)]
	].
	^(otherExtents at: cval ifAbsentPut: [self computeExtentsOfAscii: cval])
		x_advance
	
]

{ #category : #initialization }
DrsFontExtentCacheRecord >> initialize [

	super initialize.
	widthArray := Array ofSize: self class coveredCodePoints.
	heightArray := Array ofSize: self class coveredCodePoints.
	otherExtents := Dictionary new.
]

{ #category : #API }
DrsFontExtentCacheRecord >> widthOf: aCharacter [
	| cval |
	
	cval := aCharacter asciiValue.
	(cval between: 1 and: self class coveredCodePoints) ifTrue: [
		^(widthArray at: cval) ifNil: [ widthArray at: cval put: (self computeWidthOf: cval)]
	].
	^(otherExtents at: cval ifAbsentPut: [self computeExtentsOfAscii: cval])
		x_advance
	
]
