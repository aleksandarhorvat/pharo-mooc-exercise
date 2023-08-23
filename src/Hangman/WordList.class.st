"
A WordList is representation of a list of words seperated by line break on the file system.

Instance Variables
	wordListPath:	String
	wordListSize:	Integer
			
wordListPath
	- Path to the actual word list of the file system.
	
wordListSize
	- Number of lines in the word list.
"
Class {
	#name : #WordList,
	#superclass : #Object,
	#instVars : [
		'wordListPath',
		'wordListSize'
	],
	#category : #Hangman
}

{ #category : #'instance-creation' }
WordList class >> path: aFilePath [
	"A actual system path to the word list"
	^ self new initializeWithPath: aFilePath
]

{ #category : #private }
WordList >> countLines [
	"Counts the number of lines in the word list"
	| readOnlyStream count |
	count := 0.
	readOnlyStream := wordListPath asFileReference readStream.
	[ readOnlyStream atEnd ] whileFalse: [ readOnlyStream nextLine. count := count + 1 ].
	readOnlyStream close.
	^ count

	
]

{ #category : #initialize }
WordList >> initializeWithPath: aFilePath [
	"Intializes the object with a path to a word list"
	wordListPath := aFilePath.
	wordListSize := self countLines
]

{ #category : #private }
WordList >> randomIndex [
	"Get random index from one to the number of lines in the word list"
	| randomNumberGenerator |
	randomNumberGenerator :=  Random new.
	^ randomNumberGenerator nextInt: wordListSize
]

{ #category : #operations }
WordList >> randomWord [
	"Extract a random word from the word list"
	| readOnlyStream eachLine index endIndex |
	index := 0.
	endIndex := self randomIndex.
	readOnlyStream := wordListPath asFileReference readStream.
	[ index < endIndex ] whileTrue: [
		index := index + 1. 
		eachLine := readOnlyStream nextLine 
	].
	readOnlyStream close.
	^ eachLine

]
