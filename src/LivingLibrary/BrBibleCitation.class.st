Class {
	#name : #BrBibleCitation,
	#superclass : #Object,
	#instVars : [
		'translation',
		'book',
		'chapter',
		'verse'
	],
	#category : #'LivingLibrary-Bible'
}

{ #category : #accessing }
BrBibleCitation >> book [
	^ book
]

{ #category : #accessing }
BrBibleCitation >> book: aString [ 
	book := aString
]

{ #category : #accessing }
BrBibleCitation >> chapter [
	^ chapter
]

{ #category : #accessing }
BrBibleCitation >> chapter: anInteger [ 
	chapter := anInteger
]

{ #category : #actions }
BrBibleCitation >> lookUp [
	| result bible |
	
	bible := self translation
			ifNil: [ BrBible versions atRandom ]
			ifNotNil: [ BrBible versions detect: [ :e | (e version = self translation) or: [ e versionCode = self translation ] ] ].

	result := bible books detect: [ :e | e title = self book ].
	self chapter ifNil: [ ^ result ].
	
	result := result chapters at: self chapter.
	self verse ifNil: [ ^ result ].
	
	^ result at: self verse.
]

{ #category : #printing }
BrBibleCitation >> printOn: aStream [

	"Per MLA [1], the translation is actually not optional. The parenthetical citation should start with (in italics) e.g. 'New Jerusalem Bible'. Since we haven't modeled translations yet, we'll fudge a bit
	
	[1]. https://owl.purdue.edu/owl/research_and_citation/mla_style/mla_formatting_and_style_guide/mla_in_text_citations_the_basics.html"
	aStream nextPutAll: 'The Bible'.
	translation ifNotNil: [ aStream nextPutAll: ' ('; nextPutAll: translation; nextPutAll: ')' ].
	
	aStream
		nextPutAll: ', ';
		nextPutAll: self book.
	chapter ifNotNil: [ aStream space; print: chapter ].
	verse ifNotNil: [ aStream nextPut: $.; print: verse ]
]

{ #category : #accessing }
BrBibleCitation >> translation [
	^ translation
]

{ #category : #accessing }
BrBibleCitation >> translation: anObject [
	translation := anObject
]

{ #category : #accessing }
BrBibleCitation >> verse [
	^ verse
]

{ #category : #accessing }
BrBibleCitation >> verse: anInteger [ 
	verse := anInteger
]
