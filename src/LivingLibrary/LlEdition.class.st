Class {
	#name : #LlEdition,
	#superclass : #Object,
	#traits : 'LlTLibraryItem',
	#classTraits : 'LlTLibraryItem classTrait',
	#instVars : [
		'work',
		'description'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #accessing }
LlEdition >> description [
	^ self maLazyFrom: self descriptionDescription
]

{ #category : #accessing }
LlEdition >> description: anObject [
	description := anObject
]

{ #category : #'magritte-accessing' }
LlEdition >> descriptionDescription [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #description;
		yourself
]

{ #category : #printing }
LlEdition >> printOn: aStream [

	aStream
		print: work;
		nextPutAll: ', ';
		nextPutAll: description
]

{ #category : #accessing }
LlEdition >> work [
	^ self maLazyFrom: self workDescription
]

{ #category : #accessing }
LlEdition >> work: anObject [
	work := anObject
]

{ #category : #'magritte-accessing' }
LlEdition >> workDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #work;
		classes: { LlAuthoredWork };
		yourself
]
