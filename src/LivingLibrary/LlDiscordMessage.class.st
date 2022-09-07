Class {
	#name : #LlDiscordMessage,
	#superclass : #LlWebResource,
	#instVars : [
		'server',
		'channel',
		'id'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #'instance creation' }
LlDiscordMessage class >> fromLinkString: aString [

	| url |
	url := aString asUrl.
	
	^ self new
		server: url pathSegments second asNumber;
		channel: url pathSegments third asNumber;
		id: url pathSegments fourth asNumber;
		yourself
]

{ #category : #'instance creation' }
LlDiscordMessage class >> fromLinkStringExample [
	<gtExample>
	
	^ self
		given: [ 'https://discord.com/channels/729445214812504107/755319168504692778/1009824276574113804' ]
		when: [ :str | self fromLinkString: str ]
		then: [ :result | 
			result server should equal: 729445214812504107.
			result channel should equal: 755319168504692778.
			result id should equal: 1009824276574113804 ]
]

{ #category : #accessing }
LlDiscordMessage class >> isClassForString: aString [
	^ aString beginsWith: 'https://discord.com'
]

{ #category : #accessing }
LlDiscordMessage >> channel [

	^ channel
]

{ #category : #accessing }
LlDiscordMessage >> channel: anObject [

	channel := anObject
]

{ #category : #accessing }
LlDiscordMessage >> id [

	^ id
]

{ #category : #accessing }
LlDiscordMessage >> id: anObject [

	id := anObject
]

{ #category : #accessing }
LlDiscordMessage >> printOn: aStream [
	aStream
		nextPutAll: 'Discord';
		nextPutAll: ' @ ';
		print: self url
]

{ #category : #accessing }
LlDiscordMessage >> server [

	^ server
]

{ #category : #accessing }
LlDiscordMessage >> server: anObject [

	server := anObject
]

{ #category : #accessing }
LlDiscordMessage >> url [
	^ 'https://discord.com/channels' asUrl / self server asString / self channel asString / self id asString
]
