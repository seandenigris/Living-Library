Class {
	#name : #LlVitalSourceBook,
	#superclass : #LlWebResource,
	#instVars : [
		'id'
	],
	#category : #'LivingLibrary-Flickr'
}

{ #category : #examples }
LlVitalSourceBook class >> example [
	<gtExample>
	^ self 
		given: []
		when: [ 
			self new
				id: '9780879396497';
				yourself ]
		then: [ :book | book url asString should equal: 'https://online.vitalsource.com/reader/books/9780879396497' ]
]

{ #category : #examples }
LlVitalSourceBook class >> exampleFromLinkString [
	<gtExample>
	^ self 
		given: []
		when: [ 
			self fromLinkString: 'https://online.vitalsource.com/reader/books/9780879396497/pageid/132' ]
		then: [ :book | book url asString should equal: 'https://online.vitalsource.com/reader/books/9780879396497' ]
]

{ #category : #examples }
LlVitalSourceBook class >> fromLinkString: aString [
	^ self new
		id: (aString asUrl pathSegments third);
		yourself
]

{ #category : #accessing }
LlVitalSourceBook >> id [
	^ id
]

{ #category : #accessing }
LlVitalSourceBook >> id: anObject [
	id := anObject
]

{ #category : #accessing }
LlVitalSourceBook >> url [
	^ 'https://online.vitalsource.com/reader/books' asUrl / self id
]
