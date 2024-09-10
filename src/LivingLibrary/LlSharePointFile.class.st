Class {
	#name : #LlSharePointFile,
	#superclass : #LlWebResource,
	#instVars : [
		'owner',
		'file',
		'typeCodes',
		'site'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #'instance creation' }
LlSharePointFile class >> fromString: aString [

	| aUrl filePath owner typeCodes site |
	(self peCanHandleFromString: aString) ifFalse: [ self error: 'invalid SharePoint URL' ].

	aUrl := aString asUrl.
	site := self urlBaseParser parse: aString.
	typeCodes := RelativePath withAll: (aUrl pathSegments first: 3).
	owner := aUrl pathSegments fourth.
	filePath := RelativePath withAll: (aUrl pathSegments allButFirst: 4).
	
	^ self new
		site: site;
		owner: owner;
		typeCodes: typeCodes;
		file: filePath;
		yourself
]

{ #category : #'instance creation' }
LlSharePointFile class >> peCanHandleFromString: aString [

	^ self urlBaseParser matches: aString
]

{ #category : #accessing }
LlSharePointFile class >> urlBaseParser [

	^ 'https://' asPParser, self urlSubdomainGrammar flatten, '.sharepoint.com/' asPParser ==> [ :nodes | nodes second ]
]

{ #category : #accessing }
LlSharePointFile class >> urlSubdomainGrammar [
	"Any valid subdomain which does not end in '-my', which would be a OneDrive URL"
	
	| oneDriveSuffix |
	oneDriveSuffix := '-my.' asPParser.

	^ #word asPParser plus, (oneDriveSuffix not, $- asPParser, #word asPParser plus) star.
]

{ #category : #accessing }
LlSharePointFile >> downloadUrl [

	^ self urlBase withPathSegments: (self typeCodes / self owner resolvePath: self file)
]

{ #category : #accessing }
LlSharePointFile >> file [
	^ file
]

{ #category : #accessing }
LlSharePointFile >> file: anObject [
	file := anObject
]

{ #category : #accessing }
LlSharePointFile >> name [
	^ self propertyAt: #name ifAbsent: [ ^ self downloadUrl file ]
]

{ #category : #accessing }
LlSharePointFile >> owner [
	^ owner
]

{ #category : #accessing }
LlSharePointFile >> owner: anObject [
	owner := anObject
]

{ #category : #accessing }
LlSharePointFile >> printOn: aStream [
	aStream
		nextPutAll: 'Share Point';
		nextPutAll: ' @ ';
		print: self url
]

{ #category : #accessing }
LlSharePointFile >> site [
	^ site
]

{ #category : #accessing }
LlSharePointFile >> site: anObject [
	site := anObject
]

{ #category : #accessing }
LlSharePointFile >> typeCodes [
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
LlSharePointFile >> typeCodes: anObject [
	typeCodes := anObject
]

{ #category : #accessing }
LlSharePointFile >> url [

	^ self downloadUrl queryAt: 'web' put: 1
]

{ #category : #accessing }
LlSharePointFile >> urlBase [

	^ ('https://', self site, '.sharepoint.com') asUrl
]
