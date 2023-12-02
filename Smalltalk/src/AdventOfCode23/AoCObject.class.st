Class {
	#name : #AoCObject,
	#superclass : #Object,
	#category : #'AdventOfCode23-Core'
}

{ #category : #'as yet unclassified' }
AoCObject class >> resourceFileNamed: aFilename [

	^ (IceRepository repositoryNamed: 'Advent of code 2023') location
		  allChildren detect: [ :aFile | aFile basename = aFilename ]
]
