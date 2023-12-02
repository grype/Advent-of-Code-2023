Class {
	#name : #AoCDay1,
	#superclass : #AoCObject,
	#category : #'AdventOfCode23-Core'
}

{ #category : #'as yet unclassified' }
AoCDay1 class >> sampleData [

	^ '1abc2
pqr3stu8vwx
a1b2c3d4e5f
treb7uchet'
]

{ #category : #performing }
AoCDay1 >> part1 [

	| sum |
	sum := 0.
	(self class resourceFileNamed: 'day1.txt') readStreamDo: [ :stream |
		[ stream atEnd ] whileFalse: [
			| nums |
			nums := stream nextLine select: #isDecimalDigit.
			sum := sum + (nums first asString , nums last asString) asInteger ] ].
	^ sum
]
