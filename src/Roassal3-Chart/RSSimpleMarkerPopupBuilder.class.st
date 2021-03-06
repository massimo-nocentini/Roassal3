"
I create markers in the visualization
"
Class {
	#name : #RSSimpleMarkerPopupBuilder,
	#superclass : #RSAbstractChartPopupBuilder,
	#category : #'Roassal3-Chart-Popup'
}

{ #category : #hooks }
RSSimpleMarkerPopupBuilder >> shapeFor: aRSChart [
	| line box |
	line := RSLine new dashArray: #(3).
	box := aRSChart decorations first shape encompassingRectangle.
	line 
		startPoint: position x@ box top;
		endPoint: position x@ box bottom .
	^ line
	
]
