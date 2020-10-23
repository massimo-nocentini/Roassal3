Class {
	#name : #RSDocumapsMetricsProvider,
	#superclass : #RSMetricsProvider,
	#classVars : [
		'fontsExtentCache'
	],
	#category : #'Roassal3-Shapes-Text'
}

{ #category : #hooks }
RSDocumapsMetricsProvider >> extentsOf: aRSLabel [

	| fc result |
	fc := fontsExtentCache
		      at: aRSLabel font
		      ifAbsentPut: [ 
		      DrsFontExtentCacheRecord new font: aRSLabel font ].
	"
	result := OrderedCollection new: aRSLabel text size.
	aRSLabel text do: [ :each | result add: (fc extentsOf: each) ].
	^ RSTextExtents new
		  from: result;
		  yourself"

	^ fc computeTextExtentsOf: aRSLabel text
]

{ #category : #hooks }
RSDocumapsMetricsProvider >> initialize [

	super initialize.
	fontsExtentCache := Dictionary new
]
