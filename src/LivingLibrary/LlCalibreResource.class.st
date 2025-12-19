"
I could probably be modeled as an RlResource, since Calibre is storing files, but for now we will not go there since Calibre has its own API we can utilize to ignore the files as Calibre implementation details.
"
Class {
	#name : 'LlCalibreResource',
	#superclass : 'LlLibraryItem',
	#instVars : [
		'format'
	],
	#category : 'LivingLibrary-Calibre',
	#package : 'LivingLibrary',
	#tag : 'Calibre'
}

{ #category : 'examples' }
LlCalibreResource class >> example [
	<gtExample>
	^ self
		new: RlPDF
		ofWork: LlAuthoredWork exampleCalibre
]

{ #category : 'accessing' }
LlCalibreResource class >> fromString: urlString [

	| url dummyResource work |
	url := urlString asUrl.
	dummyResource := RlResource on: 'file' asFileReference, url pathSegments third.
	work := LlLibrary uniqueInstance works detect: [ :w | w calibreID = url pathSegments second asNumber ].
	
	^ LlCalibreResource
		new: dummyResource class
		ofWork: work
]

{ #category : 'instance creation' }
LlCalibreResource class >> new: anRlResourceClass ofWork: anLlAuthoredWork [
	"anRlResourceClass - the format e.g. RlPDF"

	^ self new
		work: anLlAuthoredWork;
		format: anRlResourceClass;
		yourself
]

{ #category : 'testing' }
LlCalibreResource class >> peCanHandleFromString: aString [
	^ aString beginsWith: 'calibre://'
]

{ #category : 'accessing' }
LlCalibreResource >> format [

	^ format
]

{ #category : 'accessing' }
LlCalibreResource >> format: anRlResourceClass [

	format := anRlResourceClass
]

{ #category : 'accessing' }
LlCalibreResource >> present [
	^ self url open
]

{ #category : 'accessing' }
LlCalibreResource >> presentDescription [
	<magritteActionDescription>
	^ MAActionDescription new
		gtIcon: BrGlamorousVectorIcons play;
		action: #present;
		yourself
]

{ #category : 'accessing' }
LlCalibreResource >> printOn: aStream [

	aStream 
		nextPutAll: self format typeName;
		nextPutAll: ' copy of ';
		print: self work;
		space.
	
	aStream nextPut: $(.
	super printOn: aStream.
	aStream nextPut: $).
]

{ #category : 'accessing' }
LlCalibreResource >> url [
	"Assumes current library
	Reference: https://manual.calibre-ebook.com/url_scheme.html#id3"
	| library |
	library := '_'.
	^ 'calibre://view-book' asUrl / library / self workID asString / self format calibreName
]

{ #category : 'accessing' }
LlCalibreResource >> urlForLocation: aString [
	"Assumes current library
	Reference: https://manual.calibre-ebook.com/url_scheme.html#id3"
	
	^ self url queryAt: #open_at put: aString
]

{ #category : 'accessing' }
LlCalibreResource >> workID [
	^ self work calibreID
]

{ #category : 'accessing' }
LlCalibreResource >> workUrl [
	"Assumes current library
	Reference: https://manual.calibre-ebook.com/url_scheme.html#id2"
	| library |
	library := '_'.
	^ 'calibre://show-book/' asUrl / library / self workID asString
]
