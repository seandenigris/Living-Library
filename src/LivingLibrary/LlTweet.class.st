"
URL format per [this SO thread](https://stackoverflow.com/questions/5652136/url-for-a-link-to-twitter-for-a-specific-tweet) 
"
Class {
	#name : #LlTweet,
	#superclass : #LlWebResource,
	#instVars : [
		'user',
		'id'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #'instance creation' }
LlTweet class >> fromString: aString [

	| url |
	url := aString asUrl.
	
	^ self new
		user: url pathSegments first;
		id: url pathSegments third asNumber;
		yourself
]

{ #category : #'instance creation' }
LlTweet class >> fromStringExample [
	<gtExample>
	
	^ self
		given: [ 'https://discord.com/channels/729445214812504107/755319168504692778/1009824276574113804' ]
		when: [ :str | self fromString: str ]
		then: [ :result | 
			result server should equal: 729445214812504107.
			result channel should equal: 755319168504692778.
			result id should equal: 1009824276574113804 ]
]

{ #category : #accessing }
LlTweet class >> peCanHandleFromString: aString [

	| url |
	url := aString asUrl.
	^ url scheme = 'https' 
		and: [ url host = 'twitter.com' 
			and: [ url pathSegments size = 3 
				and: [ url pathSegments second = 'status' ] ] ].
]

{ #category : #accessing }
LlTweet >> id [

	^ id
]

{ #category : #accessing }
LlTweet >> id: anObject [

	id := anObject
]

{ #category : #accessing }
LlTweet >> printOn: aStream [
	aStream
		nextPutAll: 'Tweet';
		nextPutAll: ' from ';
		nextPutAll: self user
]

{ #category : #accessing }
LlTweet >> url [
	^ 'https://twitter.com' asUrl / self user / 'status' / self id asString
]

{ #category : #accessing }
LlTweet >> user [

	^ user
]

{ #category : #accessing }
LlTweet >> user: anObject [

	user := anObject
]
