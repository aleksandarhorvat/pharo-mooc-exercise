Class {
	#name : #Die,
	#superclass : #Object,
	#instVars : [
		'faces'
	],
	#category : #Dice
}

{ #category : #'instance creation' }
Die class >> withFaces: anInteger [ 
	| die |
	die := Die new.
	die faces: anInteger.
	^ die
]

{ #category : #accessing }
Die >> faces [
	^ faces
]

{ #category : #accessing }
Die >> faces: anInteger [ 
	faces := anInteger
]

{ #category : #initialization }
Die >> initialize [
	
	super initialize.
	faces := 6
]

{ #category : #accessing }
Die >> roll [
	^ faces atRandom
]
