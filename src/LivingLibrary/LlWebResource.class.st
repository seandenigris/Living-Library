Class {
	#name : #LlWebResource,
	#superclass : #LlLibraryItem,
	#instVars : [
		'url',
		'description'
	],
	#category : 'LivingLibrary-Core'
}

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
LlWebResource >> printOn: aStream [
	aStream
		nextPutAll: self description;
		nextPutAll: ' @ ';
		print: self url
]

{ #category : #accessing }
LlWebResource >> url [
	^ url
]

{ #category : #accessing }
LlWebResource >> url: anObject [
	url := anObject
]
