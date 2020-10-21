Class {
	#name : #RSDocumapsMetricsProvider,
	#superclass : #RSMetricsProvider,
	#category : #'Roassal3-Shapes-Text'
}

{ #category : #hooks }
RSDocumapsMetricsProvider >> extentsOf: aRSLabel [

	^ DrsFontsExtentCacheRecord new
		  font: aRSLabel font;
		  computeTextExtentsOf: aRSLabel text
]
