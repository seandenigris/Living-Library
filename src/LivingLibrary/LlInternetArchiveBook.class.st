Class {
	#name : 'LlInternetArchiveBook',
	#superclass : 'LlWebResource',
	#instVars : [
		'id'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'examples' }
LlInternetArchiveBook class >> example [
	<gtExample>
	^ self 
		given: []
		when: [ 
			self new
				work: LlAuthoredWork exampleAntifragile;
				id: 'antifragilething0000tale';
				yourself ]
		then: [ :book | 
			book url asString should equal: 'https://archive.org/details/antifragilething0000tale'.
			book title should equal: LlAuthoredWork exampleAntifragile title ]
]

{ #category : 'testing' }
LlInternetArchiveBook class >> fromString: aString [
	^ self new
		id: aString asUrl pathSegments second;
		yourself
]

{ #category : 'testing' }
LlInternetArchiveBook class >> peCanHandleFromString: aString [
	^ aString beginsWith: 'https://archive.org/details/'
]

{ #category : 'as yet unclassified' }
LlInternetArchiveBook >> defaultDriverClass [
	^ RlApplescriptMediaDriver
]

{ #category : 'accessing' }
LlInternetArchiveBook >> id [
	^ id
]

{ #category : 'accessing' }
LlInternetArchiveBook >> id: anObject [
	id := anObject
]

{ #category : 'accessing' }
LlInternetArchiveBook >> url [
	^ 'https://archive.org/details' asUrl / self id
]
