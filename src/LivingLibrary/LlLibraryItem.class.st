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

{ #category : #accessing }
LlLibraryItem class >> gtSpotterNewFor: aStep [
	<gtSearch>
	
	aStep listProcessor
		title: 'New instance';
		priority: 50;
		wantsToDisplayOnEmptyQuery: false;
		filter: (PeGtDeepestSubInstanceFilter new rootClass: self; yourself)
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
LlLibraryItem >> work: aWork [
	work := aWork
]
