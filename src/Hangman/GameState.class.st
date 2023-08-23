"
A GameState is representation of the current sate of the game.

Instance Variables
	currentGuess:	String
	guessedChars:	String
	randomWord:	String
	triesLeft:	Integer

currentGuess
	- The current guess of the random word by the user.

guessedChars
	- The chars the user formally guessed.

randomWord
	- The random word needed to be guessed.

triesLeft
	- The number of tries left for the user.
"
Class {
	#name : #GameState,
	#superclass : #Object,
	#instVars : [
		'guessedChars',
		'currentGuess',
		'randomWord',
		'triesLeft'
	],
	#category : #Hangman
}

{ #category : #'instance-creation' }
GameState class >> randomWord: aRandomWord [
	"Creates a new game state with the random word"
	^ self new initializeWithWord: aRandomWord
]

{ #category : #operations }
GameState >> giveGuess: aGuess [
	"Gives a new guess, which will be checked against the random word"
	| correctGuess |
	correctGuess := self updateGuessedChars: aGuess.
	correctGuess := (self updateCurrentGuess: aGuess) or: correctGuess.
	
	"We checks if the player have guessed the word"
	((self guessedWord) or: correctGuess)
		ifTrue: [ ^ true ]
		ifFalse: [ triesLeft := triesLeft - 1 ].
		
	
]

{ #category : #operations }
GameState >> guessedWord [
	"Returns if the user has guessed the word"
	(currentGuess = randomWord)
		ifTrue: [ ^ true ]
		ifFalse: [ ^ false ].
]

{ #category : #initialize }
GameState >> initializeWithWord: aRandomWord [
	"Initializes the game state with the given random word"
	super initialize.
	triesLeft := 10.
	currentGuess := ''.
	guessedChars := ''.
	randomWord := aRandomWord.
	randomWord do: [ :noused | currentGuess := currentGuess , #_ ].
]

{ #category : #operations }
GameState >> printStatus [
	| resultString cr |
	cr := String cr.
	resultString := 'Word: ', currentGuess, cr,
						'Tries Left: ', (triesLeft asString), cr, 
						'Guessed Letters: ', guessedChars, cr.

	(triesLeft  = 10) ifTrue: [ resultString := (resultString, cr,cr,cr,cr,cr,cr,cr) ].
	(triesLeft = 9) ifTrue: [ resultString := (resultString, cr,cr,cr,cr,cr,'   ',cr,'_______________',cr,cr) ].
	(triesLeft = 8) ifTrue: [ resultString := (resultString, cr,cr,cr,'  |',cr,'  |',cr,'  |',cr,'________________',cr,cr) ].
	(triesLeft = 7)  ifTrue: [ resultString := (resultString,'  |',cr,'  |',cr,'  |',cr,'  |',cr,'  |',cr,'  |',cr,'________________',cr,cr) ].
	(triesLeft = 6) ifTrue: [ resultString := (resultString, '  |--         ',cr,'  |',cr,'  |',cr,'  |',cr,'  |',cr,'  |',cr,'  |',cr,'________________',cr,cr) ].
	(triesLeft = 5) ifTrue: [ resultString := (resultString, '  |------         ',cr,'  |',cr,'  |',cr,'  |',cr,'  |',cr,'  |',cr,'  |',cr,'________________',cr,cr) ].
	(triesLeft = 4) ifTrue: [ resultString := (resultString, '  |------         ',cr,'  |     |',cr,'  |',cr,'  |',cr,'  |',cr,'  |',cr,'  |',cr,'________________',cr,cr) ].
	(triesLeft = 3)  ifTrue: [ resultString := (resultString,'  |------         ',cr,'  |     |',cr,'  |     0',cr,'  |',cr,'  |',cr,'  |',cr,'  |',cr,'________________',cr,cr) ].
	(triesLeft = 2)  ifTrue: [ resultString := (resultString,'  |------         ',cr,'  |     |',cr,'  |     0',cr,'  |    /|\',cr,'  |',cr,'  |',cr,'  |',cr,'________________',cr,cr) ].
	(triesLeft = 1)  ifTrue: [ resultString := (resultString,'  |------         ',cr,'  |     |',cr,'  |     0',cr,'  |    /|\',cr,'  |     |',cr,'  |',cr,'  |',cr,'________________',cr,cr) ].
	(triesLeft = 0) ifTrue: [ resultString := (resultString,'  |------         ',cr,'  |     |',cr,'  |     0',cr,'  |    /|\',cr,'  |     |',cr,'  |    / \',cr,'  |',cr,'________________',cr,cr) ].
	Transcript show: resultString.

]

{ #category : #accessing }
GameState >> triesLeft [
	"returns the number of tries the player have left"
	^ triesLeft
]

{ #category : #operations }
GameState >> updateCurrentGuess: aGuess [
	"Updates the current guess with correct letters"
	| wordSize correctGuess |
	correctGuess := false.
	wordSize := randomWord size.
	
	"Updates the current guess with the guess given if the char matches one in the random word"
	1 to: wordSize do: [ :index |
		(aGuess = (randomWord at: index)) 
			ifTrue:   [ currentGuess at: index put: (randomWord at: index). 
					   correctGuess := true. ]
 			ifFalse:  [ currentGuess at: index put: (currentGuess at: index) ]
	].
	^ correctGuess
]

{ #category : #operations }
GameState >> updateGuessedChars: aGuess [
	"Updates the list of currently guessed chars"
	 ((guessedChars indexOf: aGuess ifAbsent: 0) = 0)
		ifFalse: [ ^ true ]
		ifTrue: [ guessedChars := guessedChars, ' ', (aGuess asString). ^ false ]
	
]
