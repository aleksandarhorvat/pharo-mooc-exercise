Class {
	#name : #TBSession,
	#superclass : #WASession,
	#instVars : [
		'currentAdmin'
	],
	#category : #'TinyBlog-Components'
}

{ #category : #accessing }
TBSession >> currentAdmin [
	^ currentAdmin
]

{ #category : #accessing }
TBSession >> currentAdmin: anObject [
	currentAdmin := anObject
]

{ #category : #testing }
TBSession >> isLogged [
	^ self currentAdmin notNil
]

{ #category : #action }
TBSession >> reset [
	currentAdmin := nil.
	self requestContext redirectTo: self application url.
	self unregister.
]
