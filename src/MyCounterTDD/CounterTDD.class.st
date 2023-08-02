Class {
	#name : #CounterTDD,
	#superclass : #Object,
	#instVars : [
		'count'
	],
	#category : #MyCounterTDD
}

{ #category : #'instance creation' }
CounterTDD class >> startingAt: anInteger [

	| c |
	c := CounterTDD new.
	c count: anInteger.
	^ c
]

{ #category : #accessing }
CounterTDD >> count [
	^ count
]

{ #category : #accessing }
CounterTDD >> count: anInteger [ 
	count := anInteger
]

{ #category : #operations }
CounterTDD >> decrement [
	count := count - 1
]

{ #category : #operation }
CounterTDD >> increment [

	count := count + 1
]
