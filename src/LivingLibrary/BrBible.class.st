Class {
	#name : #BrBible,
	#superclass : #Object,
	#instVars : [
		'books',
		'version',
		'versionCode'
	],
	#classInstVars : [
		'versions'
	],
	#category : 'LivingLibrary-Bible'
}

{ #category : #accessing }
BrBible class >> exampleImportVersion [
	<sampleInstance>
	"To add to DB: `BrBible versions add: self exampleImportVersion`"
	"XML downloaded from https://bible4u.net"

	| dom bible |
	bible := BrBible new
		version: 'King James Version';
		versionCode: 'KJV';
		yourself.
	dom := XMLDOMParser parseFileNamed: (FileLocator home / 'Downloads' / 'KJV.xml') fullName.
	dom // #BIBLEBOOK do: [ :bookNode | 
		| book |
		
		book := BrBibleBook new
		title: (bookNode attributeAt: #bname);
		abbreviation: (bookNode attributeAt: #bsname);
		yourself.
		
		bookNode / #CHAPTER doWithIndex: [ :chapterNode :i | 
			| verseNodes verses |
			verseNodes := chapterNode / #VERS.
			verses := verseNodes 
				collect: [ :verseNode | 
					BrBibleVerse new
						contents: verseNode contentString;
						yourself ] 
				as: OrderedCollection.
			book chapters at: i put: verses ].
		
		bible books add: book ].
	^ bible
]

{ #category : #persisting }
BrBible class >> restoreFrom: aCollection [
	versions := aCollection
]

{ #category : #persisting }
BrBible class >> spData [
	^ versions
]

{ #category : #accessing }
BrBible class >> versions [
	^ versions ifNil: [ versions := Bag new ]
]

{ #category : #accessing }
BrBible >> books [
	^ books ifNil: [ books := Bag new ]
]

{ #category : #'magritte-accessing' }
BrBible >> descriptionVersion [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #version;
		yourself
]

{ #category : #'magritte-accessing' }
BrBible >> descriptionVersionCode [
	<magritteDescription>
	^ MAStringDescription new
		accessor: #versionCode;
		yourself
]

{ #category : #printing }
BrBible >> printOn: aStream [
	aStream
		nextPutAll: self version;
		nextPutAll: ' Bible (';
		nextPutAll: self versionCode;
		nextPut: $)
]

{ #category : #accessing }
BrBible >> version [
	^ self maLazyFrom: self descriptionVersion
]

{ #category : #accessing }
BrBible >> version: anObject [
	version := anObject
]

{ #category : #accessing }
BrBible >> versionCode [
	^ self maLazyFrom: self descriptionVersionCode
]

{ #category : #accessing }
BrBible >> versionCode: anObject [
	versionCode := anObject
]
