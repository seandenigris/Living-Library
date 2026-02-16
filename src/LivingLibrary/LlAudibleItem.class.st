Class {
	#name : 'LlAudibleItem',
	#superclass : 'LlWebResource',
	#instVars : [
		'titleSlug',
		'id'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LlAudibleItem class >> fromString: aString [

	| url |
	url := aString asUrl.
	
	^ self new
		titleSlug: url pathSegments second;
		id: url pathSegments third;
		yourself
]

{ #category : 'instance creation' }
LlAudibleItem class >> fromStringExample [
	<gtExample>
	
	^ self
		given: [ 'https://www.audible.com/pd/The-Fourth-Pillar-Audiobook/B0F749M4CK' ]
		when: [ :str | self fromString: str ]
		then: [ :result | 
			result titleSlug should equal: 'The-Fourth-Pillar-Audiobook'.
			result id should equal: 'B0F749M4CK' ]
]

{ #category : 'accessing' }
LlAudibleItem class >> peCanHandleFromString: aString [

	| url |
	url := aString asUrl.
	^ url scheme = 'https' 
		and: [ url host = 'www.audible.com' 
			and: [ url pathSegments size = 3 
				and: [ url pathSegments first = 'pd' ] ] ].
]

{ #category : 'accessing' }
LlAudibleItem >> id [

	^ id
]

{ #category : 'accessing' }
LlAudibleItem >> id: anObject [

	id := anObject
]

{ #category : 'accessing' }
LlAudibleItem >> printOn: aStream [

	self work 
		ifNotNil: [ :aWork | aStream display: aWork ]
		ifNil: [ aStream nextPutAll: self titleSlug ].
	
	aStream nextPutAll: ' on Audible'
]

{ #category : 'accessing' }
LlAudibleItem >> titleSlug [
	^ titleSlug
]

{ #category : 'accessing' }
LlAudibleItem >> titleSlug: anObject [
	titleSlug := anObject
]

{ #category : 'accessing' }
LlAudibleItem >> url [
	^ 'https://www.audible.com/pd' asUrl / self titleSlug / self id
]
