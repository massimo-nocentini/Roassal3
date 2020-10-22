"
I rely on CairoFontMetricsProvider for my computation. Used in the `documaps` applicative.
"
Class {
	#name : #DrsFontsExtentCacheRecord,
	#superclass : #Object,
	#instVars : [
		'asciiTable',
		'others',
		'font',
		'height'
	],
	#category : #'Roassal3-Shapes-Text'
}

{ #category : #initialization }
DrsFontsExtentCacheRecord >> computeOther: aCharacter [ 

	^ others at: aCharacter put: (self computeTextExtentsOf: aCharacter)
]

{ #category : #initialization }
DrsFontsExtentCacheRecord >> computeTextExtentsOf: aText [
	| ext |
	ext := CairoFontMetricsProvider new
		font: font;
		extentsOf: aText asString.
	^ RSTextExtents new
		from: ext;
		yourself
]

{ #category : #initialization }
DrsFontsExtentCacheRecord >> extentsOf: aCharacter [

	| asciiValue |
	asciiValue := aCharacter asciiValue.
	(asciiValue >= 1 and: [ aCharacter asciiValue <= 255 ]) ifTrue: [ 
		^ asciiTable at: asciiValue ].
	
	^ others at: aCharacter ifAbsentPut: [ self computeOther: aCharacter ]
]

{ #category : #initialization }
DrsFontsExtentCacheRecord >> font: aFont [ 

	font := aFont.
	self precomputeASCII.
	height := aFont height.
]

{ #category : #initialization }
DrsFontsExtentCacheRecord >> height [

	^ height
]

{ #category : #initialization }
DrsFontsExtentCacheRecord >> initialize [ 

	super initialize.
	
	asciiTable := Array ofSize: 255.
	others := Dictionary new.
]

{ #category : #initialization }
DrsFontsExtentCacheRecord >> precomputeASCII [ 

	1 to: 255 do: [ :i | 
		asciiTable at: i put: (self computeTextExtentsOf: (Character value: i)) ]
]

{ #category : #initialization }
DrsFontsExtentCacheRecord >> widthOf: aCharacter [ 

	^ (self extentsOf: aCharacter) x_advance 
]
