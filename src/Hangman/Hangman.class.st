"
A Hangman is small implementation of the classic hangman game.

Instance Variables
	gameState: GameState

gameState
	- The current sate of the game.
"
Class {
	#name : #Hangman,
	#superclass : #Object,
	#instVars : [
		'gameState'
	],
	#category : #Hangman
}

{ #category : #'instance-creation' }
Hangman class >> startGame:  aFilePath [
	"Create a Hangman object and start a game of hangman with the word list given"
	^ self new startGame: aFilePath
]

{ #category : #private }
Hangman >> guess [
	"Gets a guess from the user"
	| guess |
	guess := UIManager default request: 'Please enter a guess: '.
	"Allows the user to stop the game prematurely, without making it look like an error"
	(guess isMemberOf: UndefinedObject) ifTrue: [ Halt signal: 'The game have been stopped, due to cancellation of guess' ].
	
	"We need more then one char for it to be a guess, and we need guess to be a string to check it's length"
	((guess isKindOf: String) and: [ guess size > 0 ])
		ifTrue: [ ^ guess at: 1 ]
		ifFalse: [ ^ self guess ]
]

{ #category : #private }
Hangman >> playGame [
	"Main loop of the hangman game"
	[ gameState guessedWord ] whileFalse: [
		gameState printStatus. 
		gameState giveGuess: (self guess).
		(gameState triesLeft = 0) ifTrue: [ gameState printStatus.^ false ]	 
	].
	^ true.
]

{ #category : #operations }
Hangman >> startGame: aFilePath [
	"Start a game of hangman with the word list given"
	| randomWord |
	randomWord := (WordList path: aFilePath) randomWord.
	gameState := GameState randomWord: randomWord.
	UIManager default alert: 'NOTE:  please open a transcript window for viewing the programs output'.

	self playGame
		ifTrue: [ Transcript show: 'Congratulations, you guessed the word "', randomWord, '" correctly.' ]
		ifFalse: [ Transcript show: 'You did not guess "', randomWord, '" correctly, and have been hanged.' ]

]
