Class {
	#name : #AoCDay1,
	#superclass : #Object,
	#classVars : [
		'Data'
	],
	#category : #'AdventOfCode23-Core'
}

{ #category : #'as yet unclassified' }
AoCDay1 class >> data [

	^ Data
]

{ #category : #'as yet unclassified' }
AoCDay1 class >> sampleData [

	^ '1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet'
]

{ #category : #'as yet unclassified' }
AoCDay1 >> part1 [

	^ ((self class data splitOn: Character cr) collect: [ :aString |
		   | digits |
		   digits := aString select: #isDecimalDigit.
		   (digits first asString , digits last asString) asInteger ]) sum
]
