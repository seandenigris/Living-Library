Class {
	#name : #LlLibraryItem,
	#superclass : #Object,
	#traits : 'DbTDomainObject',
	#classTraits : 'DbTDomainObject classTrait',
	#instVars : [
		'work'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #'as yet unclassified' }
LlLibraryItem class >> fromString: aString [ 
	
	| cls |
	cls := self peClassForString: aString.
	^ cls fromString: aString
]

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
LlLibraryItem >> initialize [
	super initialize.
	self ensureUUID
]

{ #category : #accessing }
LlLibraryItem >> name [
	^ self propertyAt: #name ifAbsent: [ ^ nil ]
]

{ #category : #accessing }
LlLibraryItem >> name: aString [
	^ self propertyAt: #name putRemovingNil: aString
]

{ #category : #accessing }
LlLibraryItem >> newPlayer [

	^ LlNullMediaPlayer new
]

{ #category : #'as yet unclassified' }
LlLibraryItem >> source [

	^ self
		propertyAt: #source
		ifAbsent: [ nil ]
]

{ #category : #'as yet unclassified' }
LlLibraryItem >> source: anObject [

	^ self
		propertyAt: #source
		putRemovingNil: anObject
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

{ #category : #'as yet unclassified' }
LlLibraryItem >> workEnsured [

	| aWork |
	aWork := self work ifNil: [ LlAuthoredWork titled: self title ].
	LlLibrary uniqueInstance addCopy: self of: aWork.
	^ aWork
]
