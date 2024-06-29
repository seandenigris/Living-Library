Class {
	#name : #LlWorkplace,
	#superclass : #Object,
	#instVars : [
		'items'
	],
	#classVars : [
		'UniqueInstance'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #accessing }
LlWorkplace class >> restoreFrom: anLlWorkplace [

	self uniqueInstance: anLlWorkplace.
]

{ #category : #accessing }
LlWorkplace class >> spData [

	^ self uniqueInstance
]

{ #category : #accessing }
LlWorkplace class >> uniqueInstance [
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #accessing }
LlWorkplace class >> uniqueInstance: anObject [
	UniqueInstance := anObject
]

{ #category : #accessing }
LlWorkplace >> dbCollectionAccessor [

	^ #items
]

{ #category : #accessing }
LlWorkplace >> items [
	^ items ifNil: [ items := OrderedCollection new ]
]

{ #category : #accessing }
LlWorkplace >> items: anObject [
	items := anObject
]

{ #category : #accessing }
LlWorkplace >> itemsSearchFor: aSearch [
	<gtSearch>
	
	^ aSearch explicit
		priority: 50;
		title: 'Items';
		search: [ :aContext | 
			| input |
			input := aContext searchQuery trimBoth.
			(self items select: [ :e | e url = input asUrl ]) asAsyncStream ]
]

{ #category : #accessing }
LlWorkplace >> itemsSearchNewFor: aSearch [
	<gtSearch>
	^ aSearch explicit
		title: 'New ';
		priority: 100;
		search: [ :aContext | 
			| input |
			input := aContext searchQuery trimBoth.
			(self shouldCreateNewItemFromString: input)
				ifTrue: [ {LlWorkplaceComment fromString: input} asAsyncStream ]
				ifFalse: [ {} asAsyncStream ] ];
		send: [ :result | self items add: result ]
]

{ #category : #accessing }
LlWorkplace >> shouldCreateNewItemFromString: aString [
	
	(LlWorkplaceComment peCanHandleFromString: aString) ifFalse: [ ^ false ].
	
	^ self items noneSatisfy: [ :e | e url = aString asUrl ]
]
