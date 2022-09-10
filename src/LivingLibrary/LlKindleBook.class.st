Class {
	#name : #LlKindleBook,
	#superclass : #LlWebResource,
	#instVars : [
		'id'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #examples }
LlKindleBook class >> example [
	<gtExample>
	^ self 
		given: []
		when: [ 
			self new
				id: 'B07ZTQR8P4';
				yourself ]
		then: [ :book | book url asString should equal: 'https://read.amazon.com/?asin=B07ZTQR8P4' ]
]

{ #category : #examples }
LlKindleBook class >> exampleFromString [
	<gtExample>
	^ self 
		given: []
		when: [ 
			self fromString: 'https://read.amazon.com/?asin=B07ZTQR8P4&language=en-US' ]
		then: [ :book | 
			book url asString should equal: 'https://read.amazon.com/?asin=B07ZTQR8P4'.
			book id should equal: 'B07ZTQR8P4' ]
]

{ #category : #examples }
LlKindleBook class >> fromString: aString [
	^ self new
		id: (aString asUrl queryAt: #asin);
		yourself
]

{ #category : #accessing }
LlKindleBook >> id [
	^ id
]

{ #category : #accessing }
LlKindleBook >> id: anObject [
	id := anObject
]

{ #category : #'as yet unclassified' }
LlKindleBook >> newPlayer [
	^ (LlMediaPlayer on: self)
		driver: LlApplescriptMediaDriver new;
		yourself
]

{ #category : #accessing }
LlKindleBook >> url [
	^ 'https://read.amazon.com' asUrl ? (#asin -> self id)
]
