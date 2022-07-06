Class {
	#name : #LlInterview,
	#superclass : #Object,
	#traits : 'TMagritteBootstrap',
	#classTraits : 'TMagritteBootstrap classTrait',
	#instVars : [
		'title',
		'subjects'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #'as yet unclassified' }
LlInterview >> printOn: aStream [
	title
		ifNotNil: [ aStream nextPutAll: title ]
		ifNil: [ super printOn: aStream ]
]

{ #category : #'as yet unclassified' }
LlInterview >> subjectsDescription [
	<magritteDescription>
	
	^ MAToManyRelationDescription new
		accessor: (MAVariableAccessor name: #subjects);
		label: 'Subjects';
		classes: { MpPerson };
		default: OrderedCollection new;
		priority: 200;
		yourself
]

{ #category : #'as yet unclassified' }
LlInterview >> titleDescription [
	<magritteDescription>
	
	^ MAStringDescription new
		accessor: (MAVariableAccessor name: #title);
		label: 'Title';
		priority: 100;
		yourself
]
