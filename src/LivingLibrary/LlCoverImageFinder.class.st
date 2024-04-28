Class {
	#name : #LlCoverImageFinder,
	#superclass : #Object,
	#instVars : [
		'work'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #accessing }
LlCoverImageFinder >> googleThumbnail [

	^ self work googleBooksInfo thumbnail
]

{ #category : #accessing }
LlCoverImageFinder >> openLibraryImage [

	| filename destination coverUrl didSucceed |
	"Reference: https://openlibrary.org/dev/docs/api/covers"
	filename := self work isbn asString, '-L.jpg'.
	destination := Tempfile withSuffix: 'isbn-', filename.
	coverUrl := 'https://covers.openlibrary.org/b/isbn' asUrl / filename ? (#default -> false) "if cover not found, 404 error instead of blank page".
	
	"Or (((self googleBooksInfo rawDataAt: #volumeInfo) at: #imageLinks) at: #thumbnail) asUrl"
	
	didSucceed := ZnClient new
		url: coverUrl;
		downloadTo: destination.
		
	didSucceed ifFalse: [ self error: 'failed to download cover image' ].

	^ destination asRlResource
]

{ #category : #accessing }
LlCoverImageFinder >> work [
	^ work
]

{ #category : #accessing }
LlCoverImageFinder >> work: anObject [
	work := anObject
]
