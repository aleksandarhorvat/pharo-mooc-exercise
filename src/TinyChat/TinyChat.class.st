Class {
	#name : #TinyChat,
	#superclass : #Object,
	#instVars : [
		'url',
		'login',
		'exit',
		'messages',
		'console',
		'lastMessageIndex'
	],
	#category : #'TinyChat-client'
}

{ #category : #'as yet unclassified' }
TinyChat class >> connect: aHost port: aPort login: aLogin [
	^ self new
	host: aHost port: aPort login: aLogin;
	start
]

{ #category : #'as yet unclassified' }
TinyChat >> cmdLastMessageID [
	^ self command: '/messages/count'
]

{ #category : #'as yet unclassified' }
TinyChat >> cmdMessagesFromLastIndexToEnd [
"Returns the server messages from my current last index to the last one on the server."
^ self command: '/messages' argument: lastMessageIndex
]

{ #category : #'as yet unclassified' }
TinyChat >> cmdNewMessage [
	^self command: '/messages/add'
]

{ #category : #accessing }
TinyChat >> command: aPath [
	^'{1}{2}' format: { url . aPath }
]

{ #category : #'as yet unclassified' }
TinyChat >> command: aPath argument: anArgument [
	^'{1}{2}/{3}' format: { url . aPath . anArgument asString }
]

{ #category : #actions }
TinyChat >> disconnect [
	self sendNewMessage: (TCMessage from: login text: 'I exited from the chat room.').
	exit := true
]

{ #category : #'as yet unclassified' }
TinyChat >> host: aHost port: aPort login: aLogin [
	url := 'http://' , aHost , ':' , aPort asString.
	login := aLogin
]

{ #category : #initialization }
TinyChat >> initialize [
	super initialize.
	exit := false.
	lastMessageIndex := 0.
	messages := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
TinyChat >> readLastMessageID [
	| id |
	id := (ZnClient new url: self cmdLastMessageID; get) asInteger.
	id = 0 ifTrue: [ id := 1 ].
	^ id
]

{ #category : #'as yet unclassified' }
TinyChat >> readMissingMessages [
	"Gets the new messages that have been posted since the last request."

	| response receivedMessages |
	response := (ZnClient new url: self cmdMessagesFromLastIndexToEnd;
	get).
	^ response
		ifNil: [ 0 ]
		ifNotNil: [
		receivedMessages := response substrings: (String crlf).
		receivedMessages do: [ :msg | messages add: (TCMessage
		fromString: msg) ].
		receivedMessages size.
	].
]

{ #category : #'as yet unclassified' }
TinyChat >> refreshMessages [
	[
		[ exit ] whileFalse: [
			(Delay forSeconds: 2) wait.
			lastMessageIndex := lastMessageIndex + (self
			readMissingMessages).
			console print: messages.
		]
	] fork
]

{ #category : #commands }
TinyChat >> send: aString [
	"When we send a message, we push it to the server and in addition we update the local list of posted messages."

	| msg |
	msg := TCMessage from: login text: aString.	
	self sendNewMessage: msg.
	lastMessageIndex := lastMessageIndex + (self readMissingMessages).
	console print: messages.
]

{ #category : #'as yet unclassified' }
TinyChat >> sendNewMessage: aMessage [
	^ ZnClient new
		url: self cmdNewMessage;
		formAt: 'sender' put: (aMessage sender);
		formAt: 'text' put: (aMessage text);
		post
]

{ #category : #accessing }
TinyChat >> start [
	console := TCConsole attach: self.
	self sendNewMessage: (TCMessage from: login text: 'I joined the chat room').
	lastMessageIndex := self readLastMessageID.
	self refreshMessages.
]
