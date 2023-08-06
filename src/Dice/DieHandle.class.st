Class {
	#name : #DieHandle,
	#superclass : #Object,
	#instVars : [
		'dice'
	],
	#category : #Dice
}

{ #category : #accessing }
DieHandle >> + aDieHandle [

	| h |
	h := self class new.
	self dice do: [ :each | h addDie: each ].
	aDieHandle  dice do: [ :each | h addDie: each ].
	^ h
]

{ #category : #initialization }
DieHandle >> addDie: aDie [

	dice add: aDie
]

{ #category : #accessing }
DieHandle >> dice [
	^ dice
]

{ #category : #accessing }
DieHandle >> diceNumber [

	^ dice size
]

{ #category : #initialization }
DieHandle >> initialize [ 

	super initialize.
	dice := OrderedCollection new.
]

{ #category : #accessing }
DieHandle >> maxValue [ 

	| res |
	res := 0.
	res := dice sum: [ :die | die faces ]. "dice do: [ :each | res := res + each faces ]"
	^ res 
]

{ #category : #accessing }
DieHandle >> roll [ 

	| res |
	res := 0.
	res := dice sum: [ :die | die roll ]. "dice do: [ :each | res := res + each roll ]"
	^ res 
]
