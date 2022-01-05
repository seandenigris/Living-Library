Class {
	#name : #LlLibraryItem,
	#superclass : #Object,
	#traits : 'MATPropertyOwner',
	#classTraits : 'MATPropertyOwner classTrait',
	#instVars : [
		'work'
	],
	#category : #'LivingLibrary-Core'
}

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
LlLibraryItem >> work: aWork [
	work := aWork
]
