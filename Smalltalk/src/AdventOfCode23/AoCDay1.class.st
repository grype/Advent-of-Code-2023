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

{ #category : #performing }
AoCDay1 >> part2 [

	| sum decimalWords regex |
	sum := 0.
	decimalWords := #( zero one two three four five six seven eight nine ).
	regex := RxMatcher forString:
		         '[0-9]|(' , (decimalWords joinUsing: ')|(') , ')'.

	(self class resourceFileNamed: 'day1.txt') readStreamDo: [ :stream |
		[ stream atEnd ] whileFalse: [
			| nums |
			nums := regex matchesIn: stream nextLine collect: [ :match |
				        (decimalWords indexOf: match ifAbsent: nil)
					        ifNil: [ match asInteger ]
					        ifNotNil: [ :idx | idx - 1 ] ].
			sum := sum + (nums first asString , nums last asString) asInteger ] ].
	^ sum
]
