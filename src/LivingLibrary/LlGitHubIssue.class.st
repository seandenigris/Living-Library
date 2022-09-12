Class {
	#name : #LlGitHubIssue,
	#superclass : #LlWebResource,
	#instVars : [
		'user',
		'project',
		'number'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #'instance creation' }
LlGitHubIssue class >> fromString: aString [

	| url |
	url := aString asUrl.
	
	^ self new
		user: url pathSegments first;
		project: url pathSegments second;
		number: url file asNumber;
		yourself
]

{ #category : #'instance creation' }
LlGitHubIssue class >> fromStringExample [
	<gtExample>
	
	^ self
		given: [ 'https://github.com/feenkcom/gtoolkit/issues/2786' ]
		when: [ :str | self fromString: str ]
		then: [ :result | 
			result user should equal: 'feenkcom'.
			result project should equal: 'gtoolkit'.
			result number should equal: 2786 ]
]

{ #category : #accessing }
LlGitHubIssue >> number [

	^ number
]

{ #category : #accessing }
LlGitHubIssue >> number: anObject [

	number := anObject
]

{ #category : #accessing }
LlGitHubIssue >> printOn: aStream [
	aStream
		nextPutAll: 'GH Issue: ';
		nextPutAll: self user;
		nextPutAll: ' / ';
		nextPutAll: self project;
		nextPutAll: ' / ';
		print: self number
]

{ #category : #accessing }
LlGitHubIssue >> project [

	^ project
]

{ #category : #accessing }
LlGitHubIssue >> project: anObject [

	project := anObject
]

{ #category : #accessing }
LlGitHubIssue >> url [

	^ 'https://github.com' asUrl / self user / self project / 'issues' / self number asString
]

{ #category : #accessing }
LlGitHubIssue >> url: aUrl [

	aUrl host = 'drive.google.com' ifFalse: [ self error: 'invalid google drive URL' ].
	url := 'https://drive.google.com' asUrl addPathSegments: aUrl pathSegments
]

{ #category : #accessing }
LlGitHubIssue >> user [

	^ user
]

{ #category : #accessing }
LlGitHubIssue >> user: anObject [

	user := anObject
]
