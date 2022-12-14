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
LlLibraryItem class >> gtSpotterNewFor: aSearch [
	<gtSearch>
	^ aSearch list
		title: 'New instance';
		priority: 50;
		items: [ {} ];
		filter: (PeGtDeepestSubInstanceFilter new
				rootClass: self;
				yourself)
]

{ #category : #accessing }
LlLibraryItem >> work [
	^ self maLazyInstVarUsing: self workDescription
]

{ #category : #accessing }
LlLibraryItem >> work: aWork [
	work := aWork
]

{ #category : #'magritte-accessing' }
LlLibraryItem >> workDescription [
	<magritteDescription>
	^ MAToOneRelationDescription new
		accessor: #work;
		classes: { LlAuthoredWork. LlEdition };
		yourself
]
