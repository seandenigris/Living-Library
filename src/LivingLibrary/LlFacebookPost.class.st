Class {
	#name : 'LlFacebookPost',
	#superclass : 'LlWebResource',
	#instVars : [
		'location',
		'id'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LlFacebookPost class >> fromString: aString [
	
	aString asUrl pathSegments readStreamDo: [ :pathStream |
		| location |
		location := String streamContents: [ :locationStream | 
			locationStream << pathStream next.
			locationStream contents = 'groups'
				ifTrue: [ locationStream << $/ << pathStream next ] ].
		pathStream next.
		^ self new
			location: location;
			id: pathStream next;
			yourself ].
]

{ #category : 'instance creation' }
LlFacebookPost class >> fromStringExample [
	<gtExample>
	
	^ self
		given: [ 'https://www.facebook.com/groups/123/posts/456/' ]
		when: [ :str | self fromString: str ]
		then: [ :result | 
			result location should equal: 'groups/123'.
			result id should equal: '456' ]
]

{ #category : 'accessing' }
LlFacebookPost class >> peCanHandleFromString: aString [

	| url |
	url := aString asUrl.
	^ url scheme = 'https' 
		and: [ url host = 'www.facebook.com'
			and: [ url pathSegments includes: 'posts' ] ].
]

{ #category : 'accessing' }
LlFacebookPost >> id [

	^ id
]

{ #category : 'accessing' }
LlFacebookPost >> id: anObject [

	id := anObject
]

{ #category : 'accessing' }
LlFacebookPost >> location [
	^ location
]

{ #category : 'accessing' }
LlFacebookPost >> location: anObject [
	location := anObject
]

{ #category : 'accessing' }
LlFacebookPost >> printOn: aStream [
	aStream
		nextPutAll: 'Facebook post'
]

{ #category : 'accessing' }
LlFacebookPost >> url [
	^ 'https://www.facebook.com' asUrl / self location / 'posts' / self id
]
