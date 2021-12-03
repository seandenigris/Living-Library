Class {
	#name : #LlGooglePlayBook,
	#superclass : #LlWebResource,
	#instVars : [
		'id'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #examples }
LlGooglePlayBook class >> example [
	<gtExample>
	^ self 
		given: []
		when: [ 
			self new
				work: LlAuthoredWork exampleAntifragile;
				id: '5fqbz_qGi0AC';
				yourself ]
		then: [ :book | 
			book url asString should equal: 'https://play.google.com/books/reader?id=5fqbz_qGi0AC'.
			book title should equal: LlAuthoredWork exampleAntifragile title ]
]

{ #category : #examples }
LlGooglePlayBook class >> fromLinkString: aString [
	^ self new
		id: (aString asUrl queryAt: #id);
		yourself
]

{ #category : #accessing }
LlGooglePlayBook >> id [
	^ id
]

{ #category : #accessing }
LlGooglePlayBook >> id: anObject [
	id := anObject
]

{ #category : #accessing }
LlGooglePlayBook >> url [
	^ 'https://play.google.com/books/reader' asUrl ? (#id -> self id)
]
