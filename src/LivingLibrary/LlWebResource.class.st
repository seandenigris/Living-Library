Class {
	#name : #LlWebResource,
	#superclass : #LlLibraryItem,
	#instVars : [
		'url',
		'description'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #'instance creation' }
LlWebResource class >> cachingUrl: aUrl [

	| result |
	result := self new
		url: aUrl;
		yourself.
	
	result resourceLibrary import: result cached.
	
	^ result
]

{ #category : #accessing }
LlWebResource >> author [
	^ self work author
]

{ #category : #accessing }
LlWebResource >> author: person [
	^ self work author: person
]

{ #category : #accessing }
LlWebResource >> authors [
	^ self work authors
]

{ #category : #caching }
LlWebResource >> cached [
	| file result |
	self propertyAt: #cache ifPresent: [ :c | ^ c ].
	file := Tempfile named: self url rlFilename.
	file parent ensureCreateDirectory.
	self url saveContentsToFile: file.
	result := file asRlResource
		source: self url;
		yourself.
	self propertyAt: #cache put: result.
	^ result
]

{ #category : #accessing }
LlWebResource >> citation [
	^ QuWebCitation new
		source: self url
		yourself
]

{ #category : #accessing }
LlWebResource >> description [
	^ self maLazyInstVarUsing: self descriptionDescription
]

{ #category : #accessing }
LlWebResource >> description: anObject [
	description := anObject
]

{ #category : #Magritte }
LlWebResource >> descriptionDescription [
	<magritteDescription>
	^ MAStringDescription new
			accessor: #description;
			label: 'Description';
			priority: 100;
			default: '';
			beRequired;
			yourself
]

{ #category : #accessing }
LlWebResource >> open [
	"RlResource compatibility"
	^ self view
]

{ #category : #accessing }
LlWebResource >> printOn: aStream [
	aStream
		nextPutAll: self description;
		nextPutAll: ' @ ';
		print: self url
]

{ #category : #accessing }
LlWebResource >> resourceLibrary [
	^ self propertyAt: #resourceLibrary ifAbsent: [ RlResourceLibrary uniqueInstance ]
]

{ #category : #accessing }
LlWebResource >> title [
	^ self work title
]

{ #category : #accessing }
LlWebResource >> title: aString [
	self work title: aString
]

{ #category : #accessing }
LlWebResource >> url [
	^ url
]

{ #category : #accessing }
LlWebResource >> url: anObject [
	url := anObject
]

{ #category : #accessing }
LlWebResource >> view [
	self url open
]

{ #category : #accessing }
LlWebResource >> viewDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		gtIcon: BrGlamorousIcons go;
		comment: 'Browse on web';
		action: #view;
		isLabelVisible: false;
		yourself
]

{ #category : #accessing }
LlWebResource >> work [
	^ work ifNil: [ work := LlAuthoredWork new ]
]
