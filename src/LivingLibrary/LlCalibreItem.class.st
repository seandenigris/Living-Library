Class {
	#name : #LlCalibreItem,
	#superclass : #LlLibraryItem,
	#instVars : [
		'id'
	],
	#category : #'LivingLibrary-Core'
}

{ #category : #'instance creation' }
LlCalibreItem class >> fromID: aNumber [

	^ self new
		id: aNumber;
		yourself
]

{ #category : #accessing }
LlCalibreItem >> id [

	^ id
]

{ #category : #accessing }
LlCalibreItem >> id: anObject [

	id := anObject
]

{ #category : #accessing }
LlCalibreItem >> printOn: aStream [

	aStream 
		print: self id;
		space.
	super printOn: aStream
]

{ #category : #accessing }
LlCalibreItem >> url [
	"Assumes current library
	Reference: https://manual.calibre-ebook.com/url_scheme.html#id2"
	| library |
	library := '_'.
	^ 'calibre://show-book/' asUrl / library / self id asString
]
