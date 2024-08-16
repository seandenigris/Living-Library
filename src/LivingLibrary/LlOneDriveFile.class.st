Class {
	#name : #LlOneDriveFile,
	#superclass : #LlWebResource,
	#instVars : [
		'owner',
		'file',
		'typeCodes'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #'instance creation' }
LlOneDriveFile class >> fromString: aString [

	| aUrl filePath owner typeCodes |
	(aString beginsWith: self urlBase printString) ifFalse: [ self error: 'invalid one drive URL' ].

	aUrl := aString asUrl.
	typeCodes := RelativePath withAll: (aUrl pathSegments first: 3).
	owner := aUrl pathSegments fourth.
	filePath := RelativePath withAll: (aUrl pathSegments allButFirst: 4).
	
	^ self new
		owner: owner;
		typeCodes: typeCodes;
		file: filePath;
		yourself
]

{ #category : #'instance creation' }
LlOneDriveFile class >> peCanHandleFromString: aString [

	^ aString beginsWith: self urlBase printString
]

{ #category : #accessing }
LlOneDriveFile class >> urlBase [

	^ 'https://nrny-my.sharepoint.com/' asUrl
]

{ #category : #accessing }
LlOneDriveFile >> downloadUrl [

	^ self class urlBase withPathSegments: (self typeCodes / self owner resolvePath: self file)
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
LlOneDriveFile >> typeCodes [
	^ typeCodes
	
	"
	Apparently the first code is related to file type and the second to permissions/visibility
	Characters right after the main URL: https://companyname.sharepoint.com change depending on what you are sharing:

“:f” means Folder sharing
“:w” means Word document sharing
“:x” means Excel document sharing
“:p” means PowerPoint document sharing
“:b” means PDF document sharing (https://sharepointmaven.com/the-anatomy-of-a-sharepoint-url/)

/:r - indicates a read-only link
/:e - edit link (https://sharepoint.stackexchange.com/a/270230)"
]

{ #category : #accessing }
LlOneDriveFile >> typeCodes: anObject [
	typeCodes := anObject
]

{ #category : #accessing }
LlOneDriveFile >> url [

	^ self downloadUrl queryAt: 'web' put: 1
]
