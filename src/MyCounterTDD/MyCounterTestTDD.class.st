Class {
	#name : #MyCounterTestTDD,
	#superclass : #TestCase,
	#category : #'MyCounterTDD-Test'
}

{ #category : #tests }
MyCounterTestTDD >> testCounterDecrement [

	| c |
	c := CounterTDD startingAt: 5.
	c decrement ; decrement.
	self assert: c count equals: 3
]

{ #category : #tests }
MyCounterTestTDD >> testCounterIncrement [

	| c |
	c := CounterTDD startingAt: 5.
	c increment ; increment.
	self assert: c count equals: 7
]

{ #category : #tests }
MyCounterTestTDD >> testCounterIsSetAndRead [ 

	| c |
	c := CounterTDD new.
	c count: 5.
	self assert: c count equals: 5.
]

{ #category : #tests }
MyCounterTestTDD >> testCounterStartingAt [ 

	| c |
	c := CounterTDD startingAt: 5.
	self assert: c count equals: 5
]
