Class {
	#name : 'LlGoogleBooksInfo',
	#superclass : 'Object',
	#traits : 'PeTRawDataHolder',
	#classTraits : 'PeTRawDataHolder classTrait',
	#category : 'LivingLibrary-Core',
	#package : 'LivingLibrary',
	#tag : 'Core'
}

{ #category : 'instance creation' }
LlGoogleBooksInfo class >> forIsbn: aString [

	"URL format from https://stackoverflow.com/a/7909402"
	| jsonResponse json items |
	jsonResponse := ZnEasy get: 'https://www.googleapis.com/books/v1/volumes?q=isbn:' , aString.
	json := NeoJSONReader fromString: jsonResponse contents.
	items := json at: #items.
	items size = 1 ifFalse: [ self error ].
	^ self fromDictionary: items first
]

{ #category : 'instance creation' }
LlGoogleBooksInfo class >> forWork: anLlAuthoredWork [

	^ self forIsbn: anLlAuthoredWork isbn
]

{ #category : 'accessing' }
LlGoogleBooksInfo >> thumbnail [

	| url destination didSucceed |
	url := (((self rawDataAt: #volumeInfo) at: #imageLinks) at: #thumbnail) asUrl.
	destination := Tempfile withExtension: 'jpg'.
	
	didSucceed := ZnClient new
		url: url;
		downloadTo: destination.
		
	didSucceed ifFalse: [ self error: 'failed to download cover image' ].

	^ destination asRlResource
]
