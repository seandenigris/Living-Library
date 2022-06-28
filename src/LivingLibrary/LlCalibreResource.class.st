Class {
	#name : #LlCalibreResource,
	#superclass : #LlLibraryItem,
	#category : #'LivingLibrary-Core'
}

{ #category : #'instance creation' }
LlCalibreResource class >> new: anRlResourceClass ofWork: anLlAuthoredWork [
	"anRlResourceClass - the format e.g. RlPDF"

	^ self new
		work: anLlAuthoredWork;
		format: anRlResourceClass;
		yourself
]

{ #category : #accessing }
LlCalibreResource >> printOn: aStream [

	aStream 
		print: self id;
		space.
	super printOn: aStream
]

{ #category : #accessing }
LlCalibreResource >> url [
	"Assumes current library
	Reference: https://manual.calibre-ebook.com/url_scheme.html#id3"
	| library |
	library := '_'.
	^ 'calibre://view-book' asUrl / library / self workID asString / 'EPUB'
]

{ #category : #accessing }
LlCalibreResource >> workID [
	^ self work calibreID
]

{ #category : #accessing }
LlCalibreResource >> workUrl [
	"Assumes current library
	Reference: https://manual.calibre-ebook.com/url_scheme.html#id2"
	| library |
	library := '_'.
	^ 'calibre://show-book/' asUrl / library / self id asString
]
