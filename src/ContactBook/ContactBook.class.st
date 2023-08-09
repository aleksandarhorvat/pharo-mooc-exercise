"
This class represent the Contact book that have contacts in it.
"
Class {
	#name : #ContactBook,
	#superclass : #Object,
	#instVars : [
		'contacts'
	],
	#category : #ContactBook
}

{ #category : #current }
ContactBook class >> createDefault [
	^ self new
		addContact: (Contact newNamed: 'Damien Cassou' email: 'damien@cassou.me');
		addContact: (Contact newNamed: 'Marcus Denker' email: 'marcus.denker@inria.fr');
		addContact: (Contact newNamed: 'Tudor Girba' email: 'tudor@tudorgirba.com');
		addContact: (Contact newNamed: 'Clara Allende' email: 'clari.allende@gmail.com');
		yourself
]

{ #category : #action }
ContactBook >> addContact: aContact [
	self contacts add: aContact
]

{ #category : #accessing }
ContactBook >> contacts [
	^ contacts ifNil: [ contacts := OrderedCollection new ]
]

{ #category : #action }
ContactBook >> removeContact: aContact [
	self contacts remove: aContact
]
