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
