Class {
	#name : #LlVectorSolutionsCourse,
	#superclass : #LlWebResource,
	#instVars : [
		'id'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #examples }
LlVectorSolutionsCourse class >> example [
	<gtExample>
	^ self 
		given: []
		when: [ 
			self new
				id: '1454';
				yourself ]
		then: [ :book | book url asString should equal: 'https://app.targetsolutions.com/tsapp/courses/v6/converted/1454' ]
]

{ #category : #examples }
LlVectorSolutionsCourse class >> exampleFromLinkString [
	<gtExample>
	^ self 
		given: []
		when: [ 
			self fromLinkString: 'https://app.targetsolutions.com/tsapp/courses/v6/converted/1454/index.cfm' ]
		then: [ :book | 
			book url asString should equal: 'https://app.targetsolutions.com/tsapp/courses/v6/converted/1454'.
			book id should equal: '1454' ]
]

{ #category : #examples }
LlVectorSolutionsCourse class >> fromLinkString: aString [
	| url isKnownFormat |
	url := aString asUrl.
	isKnownFormat := (url pathSegments first: 4) hasEqualElements: #(tsapp courses v6 converted).
	isKnownFormat ifFalse: [ self error: 'Unknown URL format: ', aString ].
	^ self new
		id: url pathSegments fifth;
		yourself
]

{ #category : #accessing }
LlVectorSolutionsCourse >> id [
	^ id
]

{ #category : #accessing }
LlVectorSolutionsCourse >> id: anObject [
	id := anObject
]

{ #category : #accessing }
LlVectorSolutionsCourse >> url [
	^ 'https://app.targetsolutions.com/tsapp/courses/v6/converted' asUrl addPathSegment: self id
]
