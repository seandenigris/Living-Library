Class {
	#name : #LlLepiterPage,
	#superclass : #LlLibraryItem,
	#instVars : [
		'databaseIdString',
		'idString'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #testing }
LlLepiterPage class >> peCanHandleFromString: aString [
	^ true
]

{ #category : #accessing }
LlLepiterPage >> database [

	self databaseId ifNil: [ ^ nil ].
	
	^ LeDatabasesRegistry defaultLogicalDatabase
		databaseWithID: self databaseId 
		ifNone: [ nil ]
]

{ #category : #accessing }
LlLepiterPage >> databaseId [

	^ databaseIdString
]

{ #category : #accessing }
LlLepiterPage >> databaseId: aString [

	databaseIdString := aString
]

{ #category : #accessing }
LlLepiterPage >> displayStringOn: aStream [

	aStream << self page title
]

{ #category : #accessing }
LlLepiterPage >> gtLiveFor: aView [
	<gtView>
	
	self page ifNil: [ ^ aView empty ].
	
	^ aView forward
		title: 'Live';
		priority: 10;
		object: [ self page ];
		view: #gtLiveFor:;
		yourself
]

{ #category : #accessing }
LlLepiterPage >> id [
	^ idString
]

{ #category : #accessing }
LlLepiterPage >> id: aString [
	idString := aString
]

{ #category : #accessing }
LlLepiterPage >> page [

	self database pageWithID: self id ifPresent: [ :s | ^ s ] ifAbsent: [ nil ].
]
