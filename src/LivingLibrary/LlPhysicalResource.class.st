Class {
	#name : 'LlPhysicalResource',
	#superclass : 'LlLibraryItem',
	#instVars : [
		'description',
		'location'
	],
	#category : 'LivingLibrary-Core'
}

{ #category : 'accessing' }
LlPhysicalResource >> description [
	^ description ifNil: [ self work title ]
]

{ #category : 'accessing' }
LlPhysicalResource >> description: anObject [
	description := anObject
]

{ #category : 'Magritte' }
LlPhysicalResource >> descriptionDescription [
	<magritteDescription>
	^ MAStringDescription new
			accessor: #description;
			label: 'Description';
			priority: 100;
			default: '';
			beRequired;
			yourself
]

{ #category : 'Magritte' }
LlPhysicalResource >> descriptionLocation [
	<magritteDescription>
	^ MAStringDescription new
			accessor: #location;
			label: 'Location';
			priority: 200;
			default: '';
			beRequired;
			yourself
]

{ #category : 'accessing' }
LlPhysicalResource >> location [
	^ location
]

{ #category : 'accessing' }
LlPhysicalResource >> location: anObject [
	location := anObject
]

{ #category : 'printing' }
LlPhysicalResource >> printOn: aStream [
	aStream nextPutAll: self description surroundedByDoubleQuotes.
	aStream 
		space;
		nextPutAll: (self className allButFirst: 2).
	self location ifNotNil: [ :loc | 
	aStream
		nextPutAll: ' @ ';
		nextPutAll: loc ]
]
