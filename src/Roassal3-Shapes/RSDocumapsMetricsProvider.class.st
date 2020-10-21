Class {
	#name : #RSDocumapsMetricsProvider,
	#superclass : #RSMetricsProvider,
	#instVars : [
		'fontsExtentCache'
	],
	#category : #'Roassal3-Shapes-Text'
}

{ #category : #hooks }
RSDocumapsMetricsProvider >> extentsOf: aRSLabel [

	^ (fontsExtentCache
		   at: aRSLabel font
		   ifAbsentPut: [ DrsFontsExtentCacheRecord new font: aRSLabel font ]) 
		  computeTextExtentsOf: aRSLabel text
]

{ #category : #hooks }
RSDocumapsMetricsProvider >> initialize [

	super initialize.
	fontsExtentCache := Dictionary new
]
