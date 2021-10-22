Class {
	#name : #LlLibraryItem,
	#superclass : #MAObject,
	#instVars : [
		'work'
	],
	#category : 'LivingLibrary-Core'
}

{ #category : #testing }
LlLibraryItem class >> isAbstract [
	^ false
]

{ #category : #'magritte-accessing' }
LlLibraryItem >> descriptionWork [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #work;
		classes: { LlAuthoredWork. LlEdition };
		yourself
]

{ #category : #accessing }
LlLibraryItem >> work [
	^ self maLazyInstVarUsing: self descriptionWork
]

{ #category : #accessing }
LlLibraryItem >> work: anObject [
	work := anObject
]
