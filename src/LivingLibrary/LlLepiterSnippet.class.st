Class {
	#name : #LlLepiterSnippet,
	#superclass : #LlLibraryItem,
	#instVars : [
		'databaseIdString',
		'idString'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #testing }
LlLepiterSnippet class >> peCanHandleFromString: aString [
	^ false
]

{ #category : #accessing }
LlLepiterSnippet >> database [

	self databaseId ifNil: [ ^ nil ].
	
	^ LeDatabasesRegistry defaultLogicalDatabase
		databaseWithID: self databaseId 
		ifNone: [ nil ]
]

{ #category : #accessing }
LlLepiterSnippet >> databaseId [

	^ databaseIdString
]

{ #category : #accessing }
LlLepiterSnippet >> databaseId: aString [

	databaseIdString := aString
]

{ #category : #accessing }
LlLepiterSnippet >> displayStringOn: aStream [

	aStream << self snippet contentAsString
]

{ #category : #accessing }
LlLepiterSnippet >> gtLiveFor: aView [
	<gtView>
	
	self snippet ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Live';
		priority: 10;
		object: [ self snippet ];
		view: #gtLiveFor:;
		yourself
]

{ #category : #accessing }
LlLepiterSnippet >> gtPageFor: aView [
	<gtView>
	
	self snippet ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Page';
		priority: 10;
		object: [ self snippet page ];
		view: #gtLiveFor:;
		yourself
]

{ #category : #accessing }
LlLepiterSnippet >> id [
	^ idString
]

{ #category : #accessing }
LlLepiterSnippet >> id: aString [
	idString := aString
]

{ #category : #accessing }
LlLepiterSnippet >> snippet [

	self database blockWithUID: self id ifPresent: [ :s | ^ s ] ifAbsent: [ nil ].
]
