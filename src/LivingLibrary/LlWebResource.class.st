Class {
	#name : 'LlWebResource',
	#superclass : 'LlLibraryItem',
	#traits : 'LlTCacheable',
	#classTraits : 'LlTCacheable classTrait',
	#instVars : [
		'url',
		'description'
	],
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LlWebResource class >> cachingUrl: aUrl [

	^ self new
		url: aUrl;
		saveCache;
		yourself
]

{ #category : 'instance creation' }
LlWebResource class >> fromString: aString [
	^ self new
		url: aString asUrl;
		yourself
]

{ #category : 'testing' }
LlWebResource class >> peCanHandleFromString: aString [

	| schemes |
	self == LlWebResource ifFalse: [  ^ false ].
	schemes := #('http://' 'https://').
	^ schemes anySatisfy: [ :e | aString beginsWith: e ]
]

{ #category : 'accessing' }
LlWebResource >> author [
	^ self work author
]

{ #category : 'accessing' }
LlWebResource >> author: person [
	^ self work author: person
]

{ #category : 'accessing' }
LlWebResource >> authors [
	^ self work authors
]

{ #category : 'accessing' }
LlWebResource >> citation [
	^ QuWebCitation new
		source: self url
		yourself
]

{ #category : 'accessing' }
LlWebResource >> description [
	^ self maLazyInstVarUsing: self descriptionDescription
]

{ #category : 'accessing' }
LlWebResource >> description: anObject [
	description := anObject
]

{ #category : 'Magritte' }
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

{ #category : 'caching' }
LlWebResource >> download [
	| file |
	file := Tempfile named: self url rlFilename.
	file parent ensureCreateDirectory.
	self url saveContentsToFile: file.
	^ file asRlResource
		source: self url;
		yourself
]

{ #category : 'accessing' }
LlWebResource >> open [
	"RlResource compatibility"
	^ self present
]

{ #category : 'accessing' }
LlWebResource >> present [
	self url open
]

{ #category : 'accessing' }
LlWebResource >> presentDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		gtIcon: BrGlamorousIcons go;
		comment: 'Browse on web';
		action: #present;
		isLabelVisible: false;
		yourself
]

{ #category : 'accessing' }
LlWebResource >> printOn: aStream [
	aStream
		nextPutAll: self className;
		nextPutAll: ' @ ';
		print: self url
]

{ #category : 'accessing' }
LlWebResource >> title [
	^ self work title
]

{ #category : 'accessing' }
LlWebResource >> title: aString [
	self work title: aString
]

{ #category : 'accessing' }
LlWebResource >> url [
	^ url
]

{ #category : 'accessing' }
LlWebResource >> url: anObject [
	url := anObject
]

{ #category : 'accessing' }
LlWebResource >> work [
	^ work ifNil: [ work := LlAuthoredWork new ]
]
