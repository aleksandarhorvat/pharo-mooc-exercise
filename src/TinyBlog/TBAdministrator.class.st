Class {
	#name : #TBAdministrator,
	#superclass : #Object,
	#instVars : [
		'login',
		'password'
	],
	#category : #TinyBlog
}

{ #category : #'instance creation' }
TBAdministrator class >> login: login password: password [
	^ self new
		login: login;
		password: password;
		yourself
]

{ #category : #accessing }
TBAdministrator >> login [
	^ login
]

{ #category : #accessing }
TBAdministrator >> login: anObject [
	login := anObject
]

{ #category : #accessing }
TBAdministrator >> password [
	^ password
]

{ #category : #accessing }
TBAdministrator >> password: anObject [
	password := SHA256 hashMessage: anObject
]
