Class {
	#name : #LlOneDriveFile,
	#superclass : #LlWebResource,
	#instVars : [
		'owner',
		'file'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #'instance creation' }
LlOneDriveFile class >> fromString: aString [

	| aUrl filePath |
	(aString beginsWith: self urlBase printString) ifFalse: [ self error: 'invalid one drive URL' ].

	aUrl := aString asUrl.
	filePath := RelativePath withAll: (aUrl pathSegments allButFirst: 4).
	
	^ self new
		owner: aUrl pathSegments fourth;
		file: filePath;
		yourself
]

{ #category : #'instance creation' }
LlOneDriveFile class >> peCanHandleFromString: aString [

	^ aString beginsWith: self urlBase printString
]

{ #category : #accessing }
LlOneDriveFile class >> urlBase [

	^ 'https://nrny-my.sharepoint.com/:x:/r/personal' asUrl
]

{ #category : #accessing }
LlOneDriveFile >> downloadUrl [

	^ self class urlBase withPathSegments: (self file segments copyWithFirst: self owner)
]

{ #category : #accessing }
LlOneDriveFile >> file [
	^ file
]

{ #category : #accessing }
LlOneDriveFile >> file: anObject [
	file := anObject
]

{ #category : #accessing }
LlOneDriveFile >> name [
	^ self propertyAt: #name ifAbsent: [ ^ self downloadUrl file ]
]

{ #category : #accessing }
LlOneDriveFile >> owner [
	^ owner
]

{ #category : #accessing }
LlOneDriveFile >> owner: anObject [
	owner := anObject
]

{ #category : #accessing }
LlOneDriveFile >> printOn: aStream [
	aStream
		nextPutAll: 'One Drive';
		nextPutAll: ' @ ';
		print: self url
]

{ #category : #accessing }
LlOneDriveFile >> url [

	^ self downloadUrl queryAt: 'web' put: 1
]
