Class {
	#name : #DieHandleTest,
	#superclass : #TestCase,
	#instVars : [
		'faces'
	],
	#category : #'Dice-Tests'
}

{ #category : #tests }
DieHandleTest >> testCreationAndAdding [

	| handle |
	handle := DieHandle new
		addDie: (Die withFaces: 6);
		addDie: (Die withFaces: 10);
		yourself.
	self assert: handle diceNumber equals: 2
]

{ #category : #tests }
DieHandleTest >> testCreationWithSameDie [

	| handle |
	handle := DieHandle new addDie: (Die withFaces: 6).
	self assert: handle diceNumber equals: 1.
	handle addDie: (Die withFaces: 6).
	self assert: handle diceNumber equals: 2
]

{ #category : #tests }
DieHandleTest >> testMaxValue [

	| h |
	h := DieHandle new.
	h addDie: (Die withFaces: 6).
	h addDie: (Die withFaces: 10).
	self assert: h maxValue equals: 16
]

{ #category : #tests }
DieHandleTest >> testRoll [

	| h |
	h := DieHandle new.
	h addDie: (Die withFaces: 6).
	h addDie: (Die withFaces: 10).
	10 timesRepeat: 
	[ self assert: (h roll between: h diceNumber and: h maxValue) ]
]

{ #category : #tests }
DieHandleTest >> testSimpleHandle [

	self assert: 2 D20 diceNumber equals: 2
]

{ #category : #tests }
DieHandleTest >> testSuming [

	self assert: (3 D4 + 2 D10) diceNumber equals: 5
]
