Class {
	#name : #DieTest,
	#superclass : #TestCase,
	#instVars : [
		'faces'
	],
	#category : #'Dice-Tests'
}

{ #category : #tests }
DieTest >> testInitialization [ 

	| die |
	die := Die new.
	self assert: die faces equals: 6
]

{ #category : #tests }
DieTest >> testRolling [

	| die |
	die := Die new.
	10 timesRepeat: 
	[ self assert: (die roll between: 1 and: 6) ]
]
